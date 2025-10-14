return {
  'OXY2DEV/markview.nvim',
  opts = {
    preview = {
      enabled = true,
      filetypes = { "markdown", "codecompanion" },
      ignore_buftypes = {},
    },
  },
  config = function(_, opts)
    require('markview').setup(opts)
  end,
}
