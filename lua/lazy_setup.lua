require("lazy").setup({
  spec = {
    -- import your plugins from a file or directory
    { import = "plugins" },
  },
  -- No plugin here is built with luarocks (`:checkhealth lazy` confirms it), so
  -- rocks support would only try to bootstrap a Lua 5.1 + luarocks toolchain via
  -- hererocks and report it missing. telescope and nvim-dap-python ship
  -- rockspecs, but only to list dependencies this config already declares.
  rocks = { enabled = false },
})
