return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini", {
              client = "gemini-cli",
            })
          end,
        },
      },
      strategies = {
        agent = {
          adapter = "gemini_cli",
        },
      },
    })
  end,
}