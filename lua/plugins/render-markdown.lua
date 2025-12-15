return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'codecompanion' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('render-markdown').setup({
      -- By default the plugin only renders in 'markdown' filetypes.
      -- The CodeCompanion buffer uses the 'codecompanion' filetype,
      -- so include it here to enable markdown rendering there too.
      file_types = { 'markdown', 'codecompanion' },
      render_modes = true,
      sign = {
        enabled = false,
      },
    })
  end,
}
