-- Compatibility shims for deprecated APIs on newer Neovim versions.
-- Goal: avoid noisy deprecation warnings while keeping behavior.

local M = {}

-- Neovim 0.10+ deprecates vim.tbl_islist in favor of vim.islist
-- Some plugins still call vim.tbl_islist, which triggers a warning.
-- If the new API exists, remap the deprecated one to it early in startup.
if type(vim.islist) == 'function' and type(vim.tbl_islist) == 'function' then
  vim.tbl_islist = vim.islist
end

return M

