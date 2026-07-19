return {
  'nvim-telescope/telescope.nvim',
  dependencies = { {'nvim-lua/plenary.nvim'} },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
  },
  config = function()
    local ok, telescope = pcall(require, 'telescope')
    if ok then
      pcall(telescope.load_extension, 'dap')
    end
  end
}
