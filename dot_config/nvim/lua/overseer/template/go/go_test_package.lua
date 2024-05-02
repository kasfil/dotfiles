local overseer = require "overseer"

return {
  name = "Go Run Package Test",
  desc = "Run go tests in the current package",
  builder = function()
    local packagePath = vim.fn.fnamemodify(vim.fn.expand "%:h", ":~:.")
    return {
      cmd = { "go" },
      args = { "test", "./" .. packagePath .. "/..." },
      name = "go test: run package test",
      cwd = vim.fn.getcwd(),
    }
  end,

  tags = { overseer.TAG.TEST },
  condition = {
    filetype = { "go" },
  },
}
