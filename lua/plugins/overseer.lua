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
    -- Only the user templates (poetry, single-file C/C++) are used; CMake goes
    -- through cmake-tools. Each built-in provider is probed on every
    -- :OverseerRun and reported by :checkhealth when its tool or file is
    -- missing. Drop a name from this list to bring that provider back.
    local disabled = {}
    for _, name in ipairs({
      'cargo', 'cargo-make', 'composer', 'deno', 'devenv', 'just', 'mage',
      'make', 'mise', 'mix', 'npm', 'rake', 'task', 'tox', 'vscode',
    }) do
      table.insert(disabled, 'overseer.template.' .. name)
    end
    require('overseer').setup({ disable_template_modules = disabled })
  end
}
