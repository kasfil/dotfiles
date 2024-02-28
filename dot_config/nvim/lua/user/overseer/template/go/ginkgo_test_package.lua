local overseer = require "overseer"

return {
  name = "Ginkgo Run Package Test",
  desc = "Run ginkgo tests in the current package",
  builder = function()
    local packagePath = vim.fn.fnamemodify(vim.fn.expand "%:h", ":~:.")
    return {
      cmd = { "ginkgo" },
      args = { "run", "./" .. packagePath .. "/..." },
      name = "Ginkgo: run package test",
      cwd = vim.fn.getcwd(),
    }
  end,

  tags = { overseer.TAG.TEST },
  condition = {
    filetype = { "go" },
  },
}
