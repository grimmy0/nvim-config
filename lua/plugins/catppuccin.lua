return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    -- auto_integrations is off because its detection calls vim.pack.get(),
    -- which creates an empty site/pack/core/opt on every start; :checkhealth
    -- lazy and vim.pack then both warn about it. These are the integrations
    -- it detected for this plugin set -- add one here when adding a plugin
    -- catppuccin supports.
    require('catppuccin').setup({
      flavour = 'mocha',
      auto_integrations = false,
      integrations = {
        blink_cmp = { enabled = true },
        dap = true,
        dap_ui = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        mason = true,
        mini = { enabled = true },
        notify = true,
        nvim_surround = true,
        nvimtree = true,
        overseer = true,
        render_markdown = true,
        telescope = true,
        which_key = true,
      },
    })
    vim.cmd.colorscheme 'catppuccin'
  end
}
