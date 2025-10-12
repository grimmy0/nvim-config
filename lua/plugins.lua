return require('packer').startup(function(use)
  -- Packer can manage itself
  use(require('plugins.packer'))

  use(require('plugins.telescope'))
  use(require('plugins.nvim-tree'))
  use(require('plugins.treesitter'))
  use(require('plugins.which-key'))
  use(require('plugins.catppuccin'))
  use(require('plugins.cmp'))
end)