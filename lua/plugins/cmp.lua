return {
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require('cmp')
    local has_ccmp, copilot_cmp = pcall(require, 'copilot_cmp')
    cmp.setup({
      sources = cmp.config.sources({
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      sorting = has_ccmp and {
        priority_weight = 2,
        comparators = {
          copilot_cmp.comparators.prioritize,
          copilot_cmp.comparators.score,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      } or nil,
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
      },
    })
  end,
}
