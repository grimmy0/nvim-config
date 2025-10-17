return {
  'folke/noice.nvim',
  requires = {
    'MunifTanjim/nui.nvim',
    -- optional, but recommended for a nice notifications view
    'rcarriga/nvim-notify',
  },
  config = function()
    local ok_notify, notify = pcall(require, 'notify')
    if ok_notify then
      vim.notify = notify
    end

    require('noice').setup({
      -- Do not override popupmenu; let blink.cmp handle completion UI
      popupmenu = { enabled = false },

      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          -- Do not add cmp override; this config uses blink.cmp
        },
      },

      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    })
  end,
}

