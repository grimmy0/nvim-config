if vim.g.headless then return end

local ok_mason, mason = pcall(require, 'mason')
if ok_mason then
  mason.setup()
end

local ok_mti, mti = pcall(require, 'mason-tool-installer')
if ok_mti then
  mti.setup({
    ensure_installed = { 'basedpyright', 'ruff', 'debugpy', 'mypy', 'clangd', 'clang-format', 'codelldb' },
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
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function()
    local ok_conform, conform = pcall(require, 'conform')
    if ok_conform then
      conform.format({ async = true, lsp_format = 'fallback' })
    else
      vim.lsp.buf.format({ async = true })
    end
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
    vim.keymap.set('n', '<leader>th', function()
      vim.lsp.buf.typehierarchy('subtypes')
    end, opts('LSP: Type Hierarchy (subtypes)'))
  end,
})

-- Enable filetype-based activation
vim.lsp.enable('ruff')
vim.lsp.enable('basedpyright')
vim.lsp.enable('clangd')

require('python_auto_import').setup()
