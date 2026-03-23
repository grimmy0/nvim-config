-- Compatibility shims for deprecated APIs on newer Neovim versions.
-- Goal: avoid noisy deprecation warnings while keeping behavior.

local M = {}

-- Neovim 0.10+ deprecates vim.tbl_islist in favor of vim.islist
-- Some plugins still call vim.tbl_islist, which triggers a warning.
-- If the new API exists, remap the deprecated one to it early in startup.
if type(vim.islist) == 'function' and type(vim.tbl_islist) == 'function' then
  vim.tbl_islist = vim.islist
end

-- Neovim 0.11 deprecates the table-style vim.validate({ ... }) form.
-- Some plugins still use it, so translate that legacy shape to the current
-- positional API before plugin code runs.
if type(vim.validate) == 'function' then
  local validate = vim.validate

  vim.validate = function(name, value, validator, optional, message)
    if validator ~= nil or type(name) ~= 'table' then
      return validate(name, value, validator, optional, message)
    end

    local keys = vim.tbl_keys(name)
    table.sort(keys)

    for _, key in ipairs(keys) do
      local spec = name[key]
      validate(key, spec[1], spec[2], spec[3], spec[4])
    end
  end
end

return M
