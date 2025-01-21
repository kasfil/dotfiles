local M = {}

---Get icon from predefined icon
---return empty string when missing
---@param name string
---@return string
function M.get_icon(name)
  local icons = require "user.utils.icon"
  return icons[name] or ""
end

---Set highlight helper, it can be inherit from existing hl_group. To modify part of the
---highlight include "inherit" in opts
---@param name string
---@param opts vim.api.keyset.highlight
M.apply_hl = function(name, opts)
  ---@diagnostic disable: undefined-field
  if opts.inherit then
    ---@type vim.api.keyset.highlight
    local source_opts = vim.api.nvim_get_hl(0, { name = opts.inherit, link = false, create = false }) ---@diagnostic disable-line: assign-type-mismatch
    opts = vim.tbl_deep_extend("force", source_opts, opts)

    -- remove inherit options
    opts["inherit"] = nil
  end

  vim.api.nvim_set_hl(0, name, opts)
end

---Set Keymap helper, comes with some default options
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts vim.keymap.set.Opts
M.apply_map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", {
    silent = true,
    remap = false,
  }, opts)

  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
