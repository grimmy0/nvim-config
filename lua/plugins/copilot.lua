return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  cmd = 'Copilot',
  config = function()
    if vim.g.headless then return end
    require('copilot').setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        TelescopePrompt = false,
        NvimTree = false,
        ['*'] = true,
      },
    })
  end,
}