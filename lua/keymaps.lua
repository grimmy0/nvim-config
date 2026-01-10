local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>')
vim.keymap.set('n', '<leader>bp', '<cmd>bprev<cr>')
vim.keymap.set('n', '<leader>bb', '<cmd>b#<cr>')

vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<cr>')
vim.keymap.set('n', '<leader>cA', '<cmd>CodeCompanionActions<cr>')
