return {
  'nvim-telescope/telescope.nvim', version = '0.1.x',
  dependencies = { {'nvim-lua/plenary.nvim'} },
  config = function()
    vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
    local ok, telescope = pcall(require, 'telescope')
    if ok then
      pcall(telescope.load_extension, 'dap')
    end
  end
}
