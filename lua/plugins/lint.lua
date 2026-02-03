return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "ruff", "mypy" },
    }

    local group = vim.api.nvim_create_augroup("LintOnSave", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = group,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
