-- Routes vim.ui.select through telescope. Without this, vim.ui.select falls
-- back to a cmdline inputlist(), which noice's command_palette preset then
-- renders badly -- overseer's task picker is the visible victim.
--
-- The init hook installs a stub so telescope can stay lazy: the first
-- vim.ui.select call pulls the plugin in, whose config swaps in the real
-- implementation.
return {
  'nvim-telescope/telescope-ui-select.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  lazy = true,
  init = function()
    vim.ui.select = function(...)
      require('lazy').load({ plugins = { 'telescope-ui-select.nvim' } })
      return vim.ui.select(...)
    end
  end,
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
      },
    })
    telescope.load_extension('ui-select')
  end,
}
