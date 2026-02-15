local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

-- Load compatibility shims early to avoid deprecation warnings
pcall(require, 'compat')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
vim.opt.clipboard:append('unnamedplus')

-- Headless safety: avoid writes and heavy startup
if #vim.api.nvim_list_uis() == 0 then
  vim.g.headless = true
  vim.opt.shadafile = 'NONE'
else
  vim.g.headless = false
end

require('lazy_setup')
require('autocmds')
require('keymaps')
require('diagnostics')
require('lsp')
