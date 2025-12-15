return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  config = function()
    require('nvim-tree').setup({
      view = {
        float = {
          enable = true,
        },
      },
    })
    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
  end
}