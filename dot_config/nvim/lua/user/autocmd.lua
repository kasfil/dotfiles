local aucmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local dap_repl = augroup("DapREPL", { clear = true })
aucmd("FileType", {
  pattern = "dap-repl",
  group = dap_repl,
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"

    require("dap.ext.autocompl").attach()
  end,
})

aucmd("FileType", {
  pattern = { "go", "gomod" },
  callback = function()
    vim.opt.expandtab = false
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
  end,
})

aucmd("BufEnter", {
  pattern = {"prompt", "nofile"},
  callback = function()
    vim.bo.codeium_enabled = false
  end
})
