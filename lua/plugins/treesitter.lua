return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  -- Pinned: nvim-treesitter main dropped Nvim 0.11 support in Apr 2026
  -- (c82bf96f); unpin when Fedora ships Neovim 0.12+.
  commit = '875515255192864c33981c3ed66ad94e561b904a',
  build = ':TSUpdate',
  config = function()
    -- main branch: setup() only takes install_dir; ensure_installed/highlight
    -- options from the old master branch are ignored here.
    require('nvim-treesitter').setup({})

    -- No-op for already-installed parsers.
    require('nvim-treesitter').install({
      'c', 'lua', 'vim', 'python', 'javascript', 'json', 'yaml',
      'markdown', 'markdown_inline',
    })

    -- Highlighting is not enabled automatically on the main branch; start it
    -- per buffer (markdown_inline is injection-only, not a filetype).
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true }),
      pattern = {
        'c', 'lua', 'vim', 'python', 'javascript', 'json', 'yaml', 'markdown',
      },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
