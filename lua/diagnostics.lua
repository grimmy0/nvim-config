local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
    severity = { min = vim.diagnostic.severity.HINT },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.INFO] = signs.Info,
      [vim.diagnostic.severity.HINT] = signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    focusable = false,
  },
})

vim.o.updatetime = 250
if not vim.g.headless then
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
    end,
  })
end

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>dd', function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = 'Diagnostics list' })
