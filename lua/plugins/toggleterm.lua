return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
      open_mapping = [[<c-\>]], -- Standard toggle key
    })

    -- Custom keybinding for toggling
    vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<cr>', { desc = 'Toggle Floating Terminal' })
    
    local function set_terminal_keymaps(bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.api.nvim_create_autocmd('TermOpen', {
      group = vim.api.nvim_create_augroup('ToggleTermKeymaps', { clear = true }),
      pattern = 'term://*',
      callback = function(args)
        set_terminal_keymaps(args.buf)
      end,
    })
  end
}
