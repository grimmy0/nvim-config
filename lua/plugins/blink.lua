return {
  'saghen/blink.cmp',
  dependencies = {
    'giuxtaposition/blink-cmp-copilot',
  },
  version = '*',
  config = function()
    require('blink.cmp').setup({
      completion = {
        ghost_text = {
		enabled = true,
		-- Show the ghost text when an item has been selected
  		show_with_selection = true,
  		-- Show the ghost text when no item has been selected, defaulting to the first item
  		show_without_selection = true,
  		-- Show the ghost text when the menu is open
  		show_with_menu = true,
  		-- Show the ghost text when the menu is closed
  		show_without_menu = true,
	},
        trigger = {
          show_on_keyword = true,
        },
      },
      keymap = {
        preset = 'super-tab',
      },
      sources = {
        default = { 'copilot', 'lsp', 'buffer', 'path' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
          },
        },
      },
    })
  end,
}
