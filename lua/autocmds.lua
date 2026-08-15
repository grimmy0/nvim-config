vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 180 })
  end,
})

-- Neovim ships ftplugin/python.vim (expandtab, shiftwidth=4) but nothing for c
-- or cpp, so C/C++ buffers fall back to the global tabstop=8 + noexpandtab
-- defaults. That means the Tab key inserts an 8-wide hard tab while
-- clang-format rewrites the file to 2-space soft indent on save. Match
-- clang-format's LLVM defaults (IndentWidth 2, UseTab Never) so typing and
-- formatting agree.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('CFamilyIndent', { clear = true }),
  pattern = { 'c', 'cpp', 'cuda' },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})
