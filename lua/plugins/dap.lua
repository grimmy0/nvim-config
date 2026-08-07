return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python', -- For Python debugging
    'nvim-telescope/telescope-dap.nvim', -- For telescope integration
    'nvim-neotest/nvim-nio', -- Required by nvim-dap-ui
  },
  ft = { 'python', 'c', 'cpp' },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup()
    pcall(function() require('telescope').load_extension('dap') end)

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
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
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
    local python_path = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
    if vim.fn.executable(python_path) == 0 then
      python_path = 'python'
    end
    require('dap-python').setup(python_path)

    -- C / C++ ---------------------------------------------------------------
    local tools = require('tools')

    -- codelldb >= 1.11 speaks DAP over stdio. The `type = 'server'` +
    -- `--port ${port}` form most guides still show is only needed for older
    -- versions; Mason ships 1.12.x.
    dap.adapters.codelldb = {
      type = 'executable',
      command = tools.resolve_executable('codelldb'),
    }

    -- gdb has had a native DAP interpreter since 14 and it is what nvim-dap's
    -- own wiki lists first. On this machine it also reads the libstdc++
    -- pretty-printers shipped with gcc, so g++ builds inspect far better.
    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }

    local function pick_program()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end

    -- Only offer adapters that are actually installed, so <F5> never lists a
    -- configuration that dies on a missing binary. gdb is not a Mason package;
    -- install it from the distro to make its entries appear.
    local cpp_configurations = {}

    if tools.has_executable('codelldb') then
      table.insert(cpp_configurations, {
        name = 'Launch (codelldb)',
        type = 'codelldb',
        request = 'launch',
        program = pick_program,
        cwd = '${workspaceFolder}',
        args = {},
        stopOnEntry = false,
      })
    end

    if vim.fn.executable('gdb') == 1 then
      table.insert(cpp_configurations, {
        name = 'Launch (gdb)',
        type = 'gdb',
        request = 'launch',
        program = pick_program,
        cwd = '${workspaceFolder}',
        args = {},
        stopAtBeginningOfMainSubprogram = false,
      })
      table.insert(cpp_configurations, {
        name = 'Attach to process (gdb)',
        type = 'gdb',
        request = 'attach',
        program = pick_program,
        pid = function()
          local name = vim.fn.input('Executable name (filter): ')
          return require('dap.utils').pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}',
      })
    end

    dap.configurations.cpp = cpp_configurations
    dap.configurations.c = cpp_configurations
  end
}
