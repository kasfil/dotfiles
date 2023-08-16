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

aucmd("WinLeave", {
  callback = function()
    if vim.bo.filetype == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

if vim.g.neovide then
  local function set_ime(args)
    if args.event:match "Enter$" then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end

  local ime_input = augroup("ime_input", { clear = true })
  aucmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime,
  })
  aucmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime,
  })
end
