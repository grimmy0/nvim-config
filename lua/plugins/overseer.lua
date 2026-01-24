return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerRun', 'OverseerToggle', 'OverseerTaskAction', 'OverseerOpen', 'OverseerClose', 'OverseerShell' },
  keys = {
    { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run Task' },
    { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = 'Toggle Task List' },
    { '<leader>oa', '<cmd>OverseerTaskAction<cr>', desc = 'Task Action' },
    { '<leader>oi', '<cmd>checkhealth overseer<cr>', desc = 'Overseer Health' },
  },
  config = function()
    require('overseer').setup()
  end
}
