-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/antonminashkin/.cache/nvim/packer_hererocks/2.1.1753364724/share/lua/5.1/?.lua;/Users/antonminashkin/.cache/nvim/packer_hererocks/2.1.1753364724/share/lua/5.1/?/init.lua;/Users/antonminashkin/.cache/nvim/packer_hererocks/2.1.1753364724/lib/luarocks/rocks-5.1/?.lua;/Users/antonminashkin/.cache/nvim/packer_hererocks/2.1.1753364724/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/antonminashkin/.cache/nvim/packer_hererocks/2.1.1753364724/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["blink-cmp-copilot"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/blink-cmp-copilot",
    url = "https://github.com/giuxtaposition/blink-cmp-copilot"
  },
  ["blink.cmp"] = {
    config = { "\27LJ\2\næ\3\0\0\6\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0025\3\r\0005\4\f\0=\4\14\0035\4\16\0005\5\15\0=\5\17\4=\4\18\3=\3\19\2B\0\2\1K\0\1\0\fsources\14providers\fcopilot\1\0\1\fcopilot\0\1\0\2\tname\fcopilot\vmodule\22blink-cmp-copilot\fdefault\1\0\2\fdefault\0\14providers\0\1\5\0\0\fcopilot\blsp\vbuffer\tpath\vkeymap\1\0\1\vpreset\14super-tab\15completion\1\0\3\vkeymap\0\15completion\0\fsources\0\ftrigger\1\0\1\20show_on_keyword\2\15ghost_text\1\0\2\ftrigger\0\15ghost_text\0\1\0\5\24show_with_selection\2\19show_with_menu\2\22show_without_menu\2\fenabled\2\27show_without_selection\2\nsetup\14blink.cmp\frequire\0" },
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/blink.cmp",
    url = "https://github.com/saghen/blink.cmp"
  },
  ["codecompanion.nvim"] = {
    config = { "\27LJ\2\ne\0\0\4\0\5\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\4\0D\0\3\0\1\0\1\vclient\15gemini-cli\vgemini\vextend\27codecompanion.adapters\frequireã\1\1\0\6\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\15strategies\nagent\1\0\1\nagent\0\1\0\1\fadapter\15gemini_cli\radapters\1\0\2\radapters\0\15strategies\0\thttp\1\0\1\thttp\0\15gemini_cli\1\0\1\15gemini_cli\0\0\nsetup\18codecompanion\frequire\0" },
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/codecompanion.nvim",
    url = "https://github.com/olimorris/codecompanion.nvim"
  },
  ["copilot.lua"] = {
    commands = { "Copilot" },
    config = { "\27LJ\2\ní\1\0\0\4\0\r\0\0196\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\1€K\0\1\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\a\0005\3\6\0=\3\b\0025\3\t\0=\3\n\0025\3\v\0=\3\f\2B\0\2\1K\0\1\0\14filetypes\1\0\3\6*\2\rNvimTree\1\20TelescopePrompt\1\npanel\1\0\1\fenabled\1\15suggestion\1\0\3\14filetypes\0\npanel\0\15suggestion\0\1\0\1\fenabled\1\nsetup\fcopilot\frequire\rheadless\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["mason-tool-installer.nvim"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/mason-tool-installer.nvim",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  nvim = {
    config = { "\27LJ\2\nu\0\0\3\0\a\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\1\0B\0\2\1K\0\1\0\16colorscheme\bcmd\bvim\1\0\1\fflavour\nmocha\nsetup\15catppuccin\frequire\0" },
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nt\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\tview\1\0\1\tview\0\nfloat\1\0\1\nfloat\0\1\0\1\venable\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n‘\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\4\17sync_install\1\21ensure_installed\0\14highlight\0\17auto_install\2\1\t\0\0\6c\blua\bvim\vpython\15javascript\tjson\tyaml\rmarkdown\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: codecompanion.nvim
time([[Config for codecompanion.nvim]], true)
try_loadstring("\27LJ\2\ne\0\0\4\0\5\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\4\0D\0\3\0\1\0\1\vclient\15gemini-cli\vgemini\vextend\27codecompanion.adapters\frequireã\1\1\0\6\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\15strategies\nagent\1\0\1\nagent\0\1\0\1\fadapter\15gemini_cli\radapters\1\0\2\radapters\0\15strategies\0\thttp\1\0\1\thttp\0\15gemini_cli\1\0\1\15gemini_cli\0\0\nsetup\18codecompanion\frequire\0", "config", "codecompanion.nvim")
time([[Config for codecompanion.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim
time([[Config for nvim]], true)
try_loadstring("\27LJ\2\nu\0\0\3\0\a\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\1\0B\0\2\1K\0\1\0\16colorscheme\bcmd\bvim\1\0\1\fflavour\nmocha\nsetup\15catppuccin\frequire\0", "config", "nvim")
time([[Config for nvim]], false)
-- Config for: blink.cmp
time([[Config for blink.cmp]], true)
try_loadstring("\27LJ\2\næ\3\0\0\6\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0025\3\r\0005\4\f\0=\4\14\0035\4\16\0005\5\15\0=\5\17\4=\4\18\3=\3\19\2B\0\2\1K\0\1\0\fsources\14providers\fcopilot\1\0\1\fcopilot\0\1\0\2\tname\fcopilot\vmodule\22blink-cmp-copilot\fdefault\1\0\2\fdefault\0\14providers\0\1\5\0\0\fcopilot\blsp\vbuffer\tpath\vkeymap\1\0\1\vpreset\14super-tab\15completion\1\0\3\vkeymap\0\15completion\0\fsources\0\ftrigger\1\0\1\20show_on_keyword\2\15ghost_text\1\0\2\ftrigger\0\15ghost_text\0\1\0\5\24show_with_selection\2\19show_with_menu\2\22show_without_menu\2\fenabled\2\27show_without_selection\2\nsetup\14blink.cmp\frequire\0", "config", "blink.cmp")
time([[Config for blink.cmp]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nt\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\tview\1\0\1\tview\0\nfloat\1\0\1\nfloat\0\1\0\1\venable\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n‘\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\4\17sync_install\1\21ensure_installed\0\14highlight\0\17auto_install\2\1\t\0\0\6c\blua\bvim\vpython\15javascript\tjson\tyaml\rmarkdown\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'Copilot', function(cmdargs)
          require('packer.load')({'copilot.lua'}, { cmd = 'Copilot', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'copilot.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Copilot ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'copilot.lua'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
