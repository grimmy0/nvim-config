return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  lazy = false,
  branch = "main", -- The 'regexp' branch was merged into main
  config = function()
    require('venv-selector').setup({
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    })
    
    -- Keymap
    vim.keymap.set('n', '<leader>vs', '<cmd>VenvSelect<cr>', { desc = 'Select VirtualEnv' })
  end
}
