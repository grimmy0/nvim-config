return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  -- which-key prefers mini.icons for keymap icons and :checkhealth warns
  -- when it is missing. Loaded on first require, which runs its setup().
  dependencies = { { 'nvim-mini/mini.icons', lazy = true, opts = {} } },
  config = function()
    require('which-key').setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    }
  end
}