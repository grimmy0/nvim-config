if vim.g.headless then return end

local ok_mason, mason = pcall(require, 'mason')
if ok_mason then
  mason.setup()
end

local ok_mti, mti = pcall(require, 'mason-tool-installer')
if ok_mti then
  mti.setup({
    ensure_installed = { 'basedpyright', 'ruff', 'debugpy', 'mypy' },
    auto_update = false,
    run_on_start = true,
    start_delay = 0,
  })
end

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
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

local function resolve_executable(name)
  local mason_bin = vim.fn.stdpath('data') .. '/mason/bin/' .. name
  if vim.fn.executable(mason_bin) == 1 then
    return mason_bin
  end

  local system_path = vim.fn.exepath(name)
  if system_path ~= '' then
    return system_path
  end

  return name
end

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

-- Enable filetype-based activation
vim.lsp.enable('ruff')
vim.lsp.enable('basedpyright')

require('python_auto_import').setup()
