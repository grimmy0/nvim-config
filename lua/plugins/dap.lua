return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python', -- For Python debugging
    'nvim-telescope/telescope-dap.nvim', -- For telescope integration
    'nvim-neotest/nvim-nio', -- Required by nvim-dap-ui
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Keymaps (basic)
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: Run/Continue' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'DAP: Set Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>lp', dap.set_breakpoint, { desc = 'DAP: Log Point' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'DAP: Toggle REPL' })
    vim.keymap.set('n', '<leader>do', dapui.open, { desc = 'DAP: Open UI' })
    vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'DAP: Close UI' })
    vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'DAP: Terminate' })
    vim.keymap.set('n', '<leader>ds', dap.disconnect, { desc = 'DAP: Disconnect Session' })
    vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'DAP: Evaluate' })


    -- Python specific configuration
    require('dap-python').setup()
  end
}
