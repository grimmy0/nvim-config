if vim.g.headless then return end

local ok_mason, mason = pcall(require, 'mason')
if ok_mason then
  mason.setup()
end

-- Mason has no option for extra pip packages, and every python-lsp-server
-- install or update recreates its venv. Re-adding pylsp-rope after each one
-- keeps a Mason update from silently dropping the refactorings. Registered
-- before mason-tool-installer runs, so the first install is covered too.
local ok_registry, registry = pcall(require, 'mason-registry')
if ok_registry then
  registry:on('package:install:success', function(pkg)
    if pkg.name ~= 'python-lsp-server' then
      return
    end
    local pip = vim.fs.joinpath(pkg:get_install_path(), 'venv', 'bin', 'pip')
    vim.system({ pip, 'install', '--quiet', 'pylsp-rope' }, {}, function(result)
      if result.code ~= 0 then
        vim.schedule(function()
          vim.notify('pylsp-rope install failed: ' .. result.stderr, vim.log.levels.ERROR)
        end)
      end
    end)
  end)
end

local ok_mti, mti = pcall(require, 'mason-tool-installer')
if ok_mti then
  mti.setup({
    ensure_installed = {
      'basedpyright',
      'ruff',
      'python-lsp-server',
      'debugpy',
      'mypy',
      'clangd',
      'clang-format',
      'codelldb',
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 0,
  })
end

local on_attach = function(_, bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  -- No bare `gr` mapping: Nvim 0.11 ships grr (references), grn (rename),
  -- gra (code action), gri (implementation) and grt (type definition). Mapping
  -- `gr` itself would make it a complete mapping and a prefix of all five,
  -- stalling each behind timeoutlen. Use grr for references.
  -- <leader>cf, not <leader>f: a bare <leader>f would also be a prefix of
  -- telescope's <leader>ff/fg/fb, forcing Vim to wait out timeoutlen before
  -- deciding which mapping was meant.
  vim.keymap.set('n', '<leader>cf', function()
    local ok_conform, conform = pcall(require, 'conform')
    if ok_conform then
      conform.format({ async = true, lsp_format = 'fallback' })
    else
      vim.lsp.buf.format({ async = true })
    end
  end, bufopts)

  -- Apply every available quickfix in the buffer.
  --
  -- Done one at a time, re-reading diagnostics between rounds, because each
  -- applied edit shifts the positions of the ones after it. A server only
  -- offers a quickfix when the request carries the diagnostic it fixes, so each
  -- round sends exactly one diagnostic in the context. `attempted` guards
  -- against a fix that does not clear its own diagnostic, which would otherwise
  -- loop forever.
  vim.keymap.set('n', '<leader>cF', function()
    local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
    if not client then
      return vim.notify('No LSP client attached', vim.log.levels.WARN)
    end
    local encoding = client.offset_encoding or 'utf-16'
    local applied, attempted = 0, {}

    local function step()
      local target
      for _, d in ipairs(vim.diagnostic.get(bufnr)) do
        local lsp_diagnostic = d.user_data and d.user_data.lsp
        local key = ('%d:%d:%s'):format(d.lnum, d.col, d.message)
        if lsp_diagnostic and not attempted[key] then
          attempted[key] = true
          target = lsp_diagnostic
          break
        end
      end

      if not target then
        return vim.notify(
          ('Applied %d fix%s'):format(applied, applied == 1 and '' or 'es'),
          vim.log.levels.INFO
        )
      end

      local params = {
        textDocument = vim.lsp.util.make_text_document_params(bufnr),
        range = target.range,
        context = { diagnostics = { target }, only = { 'quickfix' } },
      }
      client:request('textDocument/codeAction', params, function(_, result)
        for _, action in ipairs(result or {}) do
          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, encoding)
            applied = applied + 1
            break
          end
        end
        vim.schedule(step)
      end, bufnr)
    end

    step()
  end, bufopts)

  -- Fix only what is under the cursor: a lone quickfix applies straight away,
  -- and several still open the picker, limited to quickfixes.
  vim.keymap.set('n', '<leader>cq', function()
    vim.lsp.buf.code_action({
      context = { only = { 'quickfix' } },
      apply = true,
    })
  end, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, 'blink.cmp')
if ok_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

local resolve_executable = require('tools').resolve_executable

-- Configure defaults, then enable by name (Nvim 0.11 API)
-- Ruff
vim.lsp.config('ruff', {
  cmd = { resolve_executable('ruff'), 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})

-- BasedPyright
vim.lsp.config('basedpyright', {
  cmd = { resolve_executable('basedpyright-langserver'), '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    basedpyright = {
      analysis = {
        autoImportCompletions = true,
      },
    },
  },
})

-- pylsp, only for pylsp-rope
-- basedpyright and ruff have no extract method/variable or inline refactorings;
-- pylsp-rope adds them as code actions. Every built-in pylsp plugin is off so
-- it adds no second set of diagnostics, completions or formatting, and on_init
-- drops the capabilities basedpyright already covers so hover, rename and
-- go-to requests are not answered twice. No shared on_attach: basedpyright
-- already sets the buffer's LSP keymaps.
local pylsp_plugins = { pylsp_rope = { enabled = true, rename = false } }
for _, name in ipairs({
  'autopep8', 'flake8', 'folding', 'jedi_completion', 'jedi_definition',
  'jedi_highlight', 'jedi_hover', 'jedi_references', 'jedi_rename',
  'jedi_signature_help', 'jedi_symbols', 'jedi_type_definition', 'mccabe',
  'preload', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylint',
  'rope_autoimport', 'rope_completion', 'yapf',
  -- Not a built-in: Mason builds the venv with --system-site-packages, so
  -- pylsp also loads plugins pip-installed into ~/.local, such as
  -- python-lsp-ruff, which would duplicate the ruff server's diagnostics.
  'ruff',
}) do
  pylsp_plugins[name] = { enabled = false }
end

vim.lsp.config('pylsp', {
  cmd = { resolve_executable('pylsp') },
  capabilities = capabilities,
  settings = { pylsp = { plugins = pylsp_plugins } },
  on_init = function(client)
    local caps = client.server_capabilities
    for _, cap in ipairs({
      'completionProvider', 'hoverProvider', 'signatureHelpProvider',
      'definitionProvider', 'typeDefinitionProvider', 'referencesProvider',
      'documentHighlightProvider', 'documentSymbolProvider',
      'workspaceSymbolProvider', 'renameProvider', 'foldingRangeProvider',
      'documentFormattingProvider', 'documentRangeFormattingProvider',
    }) do
      caps[cap] = nil
    end
  end,
})

-- clangd
-- nvim-lspconfig ships lsp/clangd.lua, which negotiates clangd's non-standard
-- offsetEncoding and installs :LspClangdSwitchSourceHeader and
-- :LspClangdShowSymbolInfo. vim.lsp.config merges with tbl_deep_extend('force'),
-- so an on_attach passed here would *replace* theirs and silently drop those
-- commands -- chain it instead. filetypes and root_markers also come from there.
local clangd_upstream_on_attach = (vim.lsp.config.clangd or {}).on_attach

vim.lsp.config('clangd', {
  cmd = {
    resolve_executable('clangd'),
    '--background-index',
    -- clangd runs clang-tidy in-process, so no separate nvim-lint linter is
    -- needed (that would re-compile every TU on save for the same diagnostics).
    '--clang-tidy',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--header-insertion=iwyu',
    '--fallback-style=llvm',
    -- Mason's clangd is a major version ahead of the system clang/gcc. Asking
    -- the real driver for its include paths is what stops <vector> and friends
    -- from resolving against the wrong standard library. c++/cc come first
    -- because that is what CMake writes into compile_commands.json.
    '--query-driver=/usr/bin/c++,/usr/bin/cc,/usr/bin/g++,/usr/bin/gcc,/usr/bin/clang++,/usr/bin/clang,/usr/bin/*-g++,/usr/bin/*-gcc,/usr/lib64/ccache/*',
    '-j=' .. math.max(2, math.floor(vim.uv.available_parallelism() / 2)),
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if clangd_upstream_on_attach then
      clangd_upstream_on_attach(client, bufnr)
    end
    on_attach(client, bufnr)

    -- Inlay hints (0.10) and type hierarchy (0.11) are native, which is why
    -- clangd_extensions.nvim is not installed.
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    local opts = function(desc)
      return { buffer = bufnr, noremap = true, silent = true, desc = desc }
    end
    vim.keymap.set('n', '<leader>ih', function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, opts('LSP: Toggle Inlay Hints'))
    vim.keymap.set(
      'n',
      '<leader>a',
      '<cmd>LspClangdSwitchSourceHeader<cr>',
      opts('clangd: Alternate Source/Header')
    )
    vim.keymap.set(
      'n',
      '<leader>si',
      '<cmd>LspClangdShowSymbolInfo<cr>',
      opts('clangd: Symbol Info')
    )
    -- <leader>ch rather than <leader>th, which <leader>t (toggleterm) would
    -- shadow behind the same timeoutlen delay.
    vim.keymap.set('n', '<leader>ch', function()
      vim.lsp.buf.typehierarchy('subtypes')
    end, opts('LSP: Type Hierarchy (subtypes)'))
  end,
})

-- Enable filetype-based activation
vim.lsp.enable('ruff')
vim.lsp.enable('basedpyright')
vim.lsp.enable('pylsp')
vim.lsp.enable('clangd')

require('python_auto_import').setup()
