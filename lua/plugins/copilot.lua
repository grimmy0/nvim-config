return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  cmd = 'Copilot',
  config = function()
    if vim.g.headless then return end
    require('copilot').setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          dismiss = "<C-e>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        TelescopePrompt = false,
        NvimTree = false,
        ['*'] = true,
      },
    })
  end,
}