vim.g.mapleader = ' '

-- Load compatibility shims early to avoid deprecation warnings
pcall(require, 'compat')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

-- Headless safety: avoid writes and heavy startup
if #vim.api.nvim_list_uis() == 0 then
  vim.g.headless = true
  vim.opt.shadafile = 'NONE'
else
  vim.g.headless = false
end

require('plugins')
require('keymaps')
require('diagnostics')
require('lsp')

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
