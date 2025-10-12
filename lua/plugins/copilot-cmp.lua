return {
  'zbirenbaum/copilot-cmp',
  after = { 'copilot.lua', 'nvim-cmp' },
  event = 'InsertEnter',
  requires = { 'zbirenbaum/copilot.lua' },
  config = function()
    if vim.g.headless then return end
    local ok, copilot_cmp = pcall(require, 'copilot_cmp')
    if ok then
      copilot_cmp.setup()
    end
  end,
}
