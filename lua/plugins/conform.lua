return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
        -- "clang-format"; the "clang_format" alias is deprecated in conform.
        -- Falls back to LLVM style when a project has no .clang-format file.
        c = { "clang-format" },
        cpp = { "clang-format" },
        cuda = { "clang-format" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
    })

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
