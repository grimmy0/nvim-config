return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local install_dir = vim.fn.stdpath('data') .. '/site'
    require('nvim-treesitter').setup {
      install_dir = install_dir,
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    local desired = { "c", "lua", "vim", "python", "javascript", "json", "yaml", "markdown", "markdown_inline" }
    local installed = {}
    for _, lang in ipairs(require('nvim-treesitter.info').installed_parsers()) do
      installed[lang] = true
    end
    local missing = {}
    for _, lang in ipairs(desired) do
      if not installed[lang] then
        table.insert(missing, lang)
      end
    end
    if #missing > 0 then
      require('nvim-treesitter').install(missing)
    end
  end
}
