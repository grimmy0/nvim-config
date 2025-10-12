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
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["copilot-cmp"] = {
    config = { "\27LJ\2\nr\0\0\4\0\a\0\0156\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\1€K\0\1\0006\0\3\0006\2\4\0'\3\5\0B\0\3\3\15\0\0\0X\2\2€9\2\6\1B\2\1\1K\0\1\0\nsetup\16copilot_cmp\frequire\npcall\rheadless\6g\bvim\0" },
    load_after = {
      ["copilot.lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/opt/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    after = { "copilot-cmp" },
    commands = { "Copilot" },
    config = { "\27LJ\2\ní\1\0\0\4\0\r\0\0196\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\1€K\0\1\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\a\0005\3\6\0=\3\b\0025\3\t\0=\3\n\0025\3\v\0=\3\f\2B\0\2\1K\0\1\0\14filetypes\1\0\3\rNvimTree\1\20TelescopePrompt\1\6*\2\npanel\1\0\1\fenabled\1\15suggestion\1\0\3\15suggestion\0\14filetypes\0\npanel\0\1\0\1\fenabled\1\nsetup\fcopilot\frequire\rheadless\6g\bvim\0" },
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
  ["nvim-cmp"] = {
    after = { "copilot-cmp" },
    config = { "\27LJ\2\nÆ\a\0\0\v\0-\0o6\0\0\0'\2\1\0B\0\2\0026\1\2\0006\3\0\0'\4\3\0B\1\3\0039\3\4\0005\5\v\0009\6\5\0009\6\6\0064\b\5\0005\t\a\0>\t\1\b5\t\b\0>\t\2\b5\t\t\0>\t\3\b5\t\n\0>\t\4\bB\6\2\2=\6\6\5\15\0\1\0X\6/€5\6\f\0004\a\f\0009\b\r\0029\b\14\b>\b\1\a9\b\r\0029\b\15\b>\b\2\a9\b\5\0009\b\16\b9\b\17\b>\b\3\a9\b\5\0009\b\16\b9\b\18\b>\b\4\a9\b\5\0009\b\16\b9\b\15\b>\b\5\a9\b\5\0009\b\16\b9\b\19\b>\b\6\a9\b\5\0009\b\16\b9\b\20\b>\b\a\a9\b\5\0009\b\16\b9\b\21\b>\b\b\a9\b\5\0009\b\16\b9\b\22\b>\b\t\a9\b\5\0009\b\16\b9\b\23\b>\b\n\a9\b\5\0009\b\16\b9\b\24\b>\b\v\a=\a\r\6\14\0\6\0X\a\1€+\6\0\0=\6\25\0055\6\28\0009\a\26\0009\a\27\aB\a\1\2=\a\29\0069\a\26\0009\a\30\aB\a\1\2=\a\31\0069\a\26\0009\a \a)\tüÿB\a\2\2=\a!\0069\a\26\0009\a \a)\t\4\0B\a\2\2=\a\"\0069\a\26\0009\a#\aB\a\1\2=\a$\0069\a\26\0009\a%\aB\a\1\2=\a&\0069\a\26\0009\a'\a5\t*\0009\n(\0009\n)\n=\n+\tB\a\2\2=\a,\6=\6\26\5B\3\2\1K\0\1\0\t<CR>\rbehavior\1\0\2\vselect\2\rbehavior\0\vInsert\20ConfirmBehavior\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\a\n<C-e>\0\n<C-d>\0\t<CR>\0\n<C-n>\0\n<C-p>\0\14<C-Space>\0\n<C-f>\0\21select_prev_item\fmapping\fsorting\norder\vlength\14sort_text\tkind\rlocality\18recently_used\nexact\voffset\fcompare\nscore\15prioritize\16comparators\1\0\2\20priority_weight\3\2\16comparators\0\1\0\3\fsources\0\fsorting\0\fmapping\0\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\1\0\1\tname\fcopilot\fsources\vconfig\nsetup\16copilot_cmp\npcall\bcmp\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/antonminashkin/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
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
    config = { "\27LJ\2\n‘\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\2\venable\2&additional_vim_regex_highlighting\1\21ensure_installed\1\0\4\17sync_install\1\14highlight\0\17auto_install\2\21ensure_installed\0\1\t\0\0\6c\blua\bvim\vpython\15javascript\tjson\tyaml\rmarkdown\nsetup\28nvim-treesitter.configs\frequire\0" },
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
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nÆ\a\0\0\v\0-\0o6\0\0\0'\2\1\0B\0\2\0026\1\2\0006\3\0\0'\4\3\0B\1\3\0039\3\4\0005\5\v\0009\6\5\0009\6\6\0064\b\5\0005\t\a\0>\t\1\b5\t\b\0>\t\2\b5\t\t\0>\t\3\b5\t\n\0>\t\4\bB\6\2\2=\6\6\5\15\0\1\0X\6/€5\6\f\0004\a\f\0009\b\r\0029\b\14\b>\b\1\a9\b\r\0029\b\15\b>\b\2\a9\b\5\0009\b\16\b9\b\17\b>\b\3\a9\b\5\0009\b\16\b9\b\18\b>\b\4\a9\b\5\0009\b\16\b9\b\15\b>\b\5\a9\b\5\0009\b\16\b9\b\19\b>\b\6\a9\b\5\0009\b\16\b9\b\20\b>\b\a\a9\b\5\0009\b\16\b9\b\21\b>\b\b\a9\b\5\0009\b\16\b9\b\22\b>\b\t\a9\b\5\0009\b\16\b9\b\23\b>\b\n\a9\b\5\0009\b\16\b9\b\24\b>\b\v\a=\a\r\6\14\0\6\0X\a\1€+\6\0\0=\6\25\0055\6\28\0009\a\26\0009\a\27\aB\a\1\2=\a\29\0069\a\26\0009\a\30\aB\a\1\2=\a\31\0069\a\26\0009\a \a)\tüÿB\a\2\2=\a!\0069\a\26\0009\a \a)\t\4\0B\a\2\2=\a\"\0069\a\26\0009\a#\aB\a\1\2=\a$\0069\a\26\0009\a%\aB\a\1\2=\a&\0069\a\26\0009\a'\a5\t*\0009\n(\0009\n)\n=\n+\tB\a\2\2=\a,\6=\6\26\5B\3\2\1K\0\1\0\t<CR>\rbehavior\1\0\2\vselect\2\rbehavior\0\vInsert\20ConfirmBehavior\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\a\n<C-e>\0\n<C-d>\0\t<CR>\0\n<C-n>\0\n<C-p>\0\14<C-Space>\0\n<C-f>\0\21select_prev_item\fmapping\fsorting\norder\vlength\14sort_text\tkind\rlocality\18recently_used\nexact\voffset\fcompare\nscore\15prioritize\16comparators\1\0\2\20priority_weight\3\2\16comparators\0\1\0\3\fsources\0\fsorting\0\fmapping\0\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\1\0\1\tname\fcopilot\fsources\vconfig\nsetup\16copilot_cmp\npcall\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nt\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\tview\1\0\1\tview\0\nfloat\1\0\1\nfloat\0\1\0\1\venable\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n‘\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\2\venable\2&additional_vim_regex_highlighting\1\21ensure_installed\1\0\4\17sync_install\1\14highlight\0\17auto_install\2\21ensure_installed\0\1\t\0\0\6c\blua\bvim\vpython\15javascript\tjson\tyaml\rmarkdown\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim
time([[Config for nvim]], true)
try_loadstring("\27LJ\2\nu\0\0\3\0\a\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\1\0B\0\2\1K\0\1\0\16colorscheme\bcmd\bvim\1\0\1\fflavour\nmocha\nsetup\15catppuccin\frequire\0", "config", "nvim")
time([[Config for nvim]], false)

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
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'copilot.lua', 'copilot-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
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
