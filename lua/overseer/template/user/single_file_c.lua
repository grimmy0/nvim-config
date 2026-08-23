-- Compile-and-run for standalone C/C++ files.
--
-- cmake-tools.nvim covers real projects; this exists for scratch files with no
-- CMakeLists.txt, where <leader>mr has no target to launch. Overseer globs
-- lua/overseer/template/**/*.lua off the runtimepath, so this file needs no
-- registration.

local TOOLCHAIN = {
  c = { cc = 'gcc', std = 'c23' },
  cpp = { cc = 'g++', std = 'c++23' },
}

-- gcc/clang diagnostics. The first branch captures the severity so warnings and
-- errors are typed correctly in the quickfix list.
local ERRORFORMAT = table.concat({
  '%f:%l:%c: %trror: %m',
  '%f:%l:%c: %tarning: %m',
  '%f:%l:%c: %tote: %m',
  '%f:%l:%c: %m',
  '%f:%l: %m',
}, ',')

---Build artifacts land outside the source tree so scratch dirs stay clean.
---@param src string
---@return string
local function binary_for(src)
  local dir = vim.fs.joinpath(vim.fn.stdpath('cache'), 'overseer-single-file')
  vim.fn.mkdir(dir, 'p')
  return vim.fs.joinpath(dir, (vim.fn.fnamemodify(src, ':t:r')))
end

---@param parts string[]
---@return string
local function shell(parts)
  local escaped = {}
  for _, p in ipairs(parts) do
    table.insert(escaped, vim.fn.shellescape(p))
  end
  return table.concat(escaped, ' ')
end

---@param ft string
---@param src string
---@param std string
---@param flags string[]
---@return string[]
local function compile_argv(ft, src, std, flags)
  local argv = { TOOLCHAIN[ft].cc, '-std=' .. std }
  vim.list_extend(argv, flags)
  vim.list_extend(argv, { src, '-o', binary_for(src) })
  return argv
end

local DEFAULT_FLAGS = { '-g', '-O0', '-Wall', '-Wextra' }

local function params_for(ft)
  return {
    std = {
      type = 'string',
      default = TOOLCHAIN[ft].std,
      desc = 'Language standard passed as -std=',
    },
    flags = {
      type = 'list',
      subtype = { type = 'string' },
      delimiter = ' ',
      default = DEFAULT_FLAGS,
      desc = 'Extra compiler flags',
    },
    args = {
      type = 'list',
      subtype = { type = 'string' },
      delimiter = ' ',
      optional = true,
      default = {},
      desc = 'Arguments passed to the compiled program',
    },
  }
end

-- overseer's `default` alias is only on_exit_set_status / on_complete_notify /
-- on_complete_dispose -- nothing that shows output. open_output must be
-- attached explicitly, and with on_start = 'always': its own default of
-- 'if_no_on_output_quickfix' would skip opening precisely because these tasks
-- also attach on_output_quickfix.
--
-- focus = true is required for direction = 'float', not a preference:
-- open_fullscreen_float enters the window and registers a WinLeave autocmd that
-- closes it, while open_output with focus = false restores the previous window
-- immediately afterwards -- so the float would open and instantly close.
local function run_components()
  return {
    { 'on_output_quickfix', errorformat = ERRORFORMAT, items_only = true, open_on_match = true },
    { 'open_output', on_start = 'always', direction = 'float', focus = true },
    'default',
  }
end

-- Compile-only stays quiet: errors land in the quickfix, success shows nothing.
local function build_components()
  return {
    { 'on_output_quickfix', errorformat = ERRORFORMAT, items_only = true, open_on_match = true },
    'default',
  }
end

---@type overseer.TemplateFileProvider
return {
  condition = { filetype = { 'c', 'cpp' } },
  generator = function(search)
    local ft = search.filetype
    if not TOOLCHAIN[ft] then
      return {}
    end

    local src = vim.api.nvim_buf_get_name(0)
    if src == '' or vim.fn.filereadable(src) ~= 1 then
      return {}
    end
    local cwd = vim.fs.dirname(src)
    local label = vim.fn.fnamemodify(src, ':t')

    local function run_task(params)
      local compile = compile_argv(ft, src, params.std, params.flags or {})
      local run = { binary_for(src) }
      vim.list_extend(run, params.args or {})
      return {
        -- String cmd goes through the shell, which is what lets the run step
        -- be gated on a successful compile.
        cmd = shell(compile) .. ' && ' .. shell(run),
        cwd = cwd,
        components = run_components(),
      }
    end

    local defaults = { std = TOOLCHAIN[ft].std, flags = DEFAULT_FLAGS, args = {} }

    return {
      {
        -- No params: picking this runs straight away with the defaults.
        name = 'C/C++: build & run ' .. label,
        builder = function()
          return run_task(defaults)
        end,
      },
      {
        name = 'C/C++: build & run ' .. label .. ' (args...)',
        params = params_for(ft),
        builder = function(params)
          return run_task(params)
        end,
      },
      {
        name = 'C/C++: build ' .. label,
        builder = function()
          return {
            cmd = compile_argv(ft, src, defaults.std, defaults.flags),
            cwd = cwd,
            components = build_components(),
          }
        end,
      },
    }
  end,
}
