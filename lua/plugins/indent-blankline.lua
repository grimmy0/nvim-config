return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    require('ibl').setup({
      indent = {
        char = '┊',
      },
      exclude = {
        filetypes = {
          'help',
          'terminal',
          'dashboard',
          'NvimTree',
          'Trouble',
          'lazy',
          'mason',
          'lspinfo',
          'toggleterm',
        },
        buftypes = {
          'terminal',
          'nofile',
        },
      },
    })
  end
}