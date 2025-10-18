return {
  'folke/noice.nvim',
  requires = {
    'MunifTanjim/nui.nvim',
    -- optional, but recommended for a nice notifications view
    'rcarriga/nvim-notify',
  },
  config = function()
    -- Work around a Noice health check edge-case where debug.getinfo
    -- is called on a non-function. Make it resilient.
    local ok_health, health = pcall(require, 'noice.health')
    if ok_health and type(health.get_source) == 'function' then
      local orig = health.get_source
      health.get_source = function(fn)
        if type(fn) ~= 'function' then
          return { line = -1, source = 'unknown', plugin = 'unknown' }
        end
        local ok, info = pcall(debug.getinfo, fn, 'S')
        if not ok or not info or type(info.source) ~= 'string' then
          return { line = -1, source = 'unknown', plugin = 'unknown' }
        end
        -- reproduce original logic with safe guards
        local source = info.source:gsub('^@', '')
        local ret = { line = info.linedefined or -1, source = source, plugin = 'unknown' }
        if source:find('noice') then
          ret.plugin = 'noice.nvim'
        elseif source:find('/runtime/lua/') then
          ret.plugin = 'nvim'
        else
          local opt = source:match('/pack/[^%/]-/opt/([^%/]-)/')
          local start = source:match('/pack/[^%/]-/start/([^%/]-)/')
          ret.plugin = opt or start or 'unknown'
        end
        return ret
      end
    end
    local ok_notify, notify = pcall(require, 'notify')
    if ok_notify then
      vim.notify = notify
    end

    require('noice').setup({
      health = { checker = false },
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
