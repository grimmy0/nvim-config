return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
    })

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
