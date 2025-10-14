return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'codecompanion' },
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('render-markdown').setup({
      render_modes = true,
      sign = {
        enabled = false,
      },
    })
  end,
}
