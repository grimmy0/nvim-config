return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- New setup for nvim-treesitter (without configs module)
    require('nvim-treesitter').setup({
      ensure_installed = { "c", "lua", "vim", "python", "javascript", "json", "yaml", "markdown", "markdown_inline" },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end
}