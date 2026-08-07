-- Shared lookup for external tooling installed by Mason or the system.
local M = {}

--- Resolve a tool to an absolute path.
--- Mason wins over $PATH so Mason updates actually take effect; the bare name is
--- the last resort so callers surface a readable "not executable" error instead
--- of silently launching nothing.
---@param name string
---@return string
function M.resolve_executable(name)
  local mason_bin = vim.fn.stdpath('data') .. '/mason/bin/' .. name
  if vim.fn.executable(mason_bin) == 1 then
    return mason_bin
  end

  local system_path = vim.fn.exepath(name)
  if system_path ~= '' then
    return system_path
  end

  return name
end

--- True when the tool can actually be run. Used to hide debug configurations for
--- adapters that are not installed.
---@param name string
---@return boolean
function M.has_executable(name)
  return vim.fn.executable(M.resolve_executable(name)) == 1
end

return M
