return {
  'stevearc/overseer.nvim',
  lazy = false,
  config = function()
    require('overseer').setup({
      templates = { "builtin", "poetry" },
    })

    -- Keybindings
    vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<cr>', { desc = 'Run Task' })
    vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<cr>', { desc = 'Toggle Task List' })
    vim.keymap.set('n', '<leader>oa', '<cmd>OverseerTaskAction<cr>', { desc = 'Task Action' })
    vim.keymap.set('n', '<leader>oi', '<cmd>OverseerInfo<cr>', { desc = 'Overseer Info' })
  end
}
