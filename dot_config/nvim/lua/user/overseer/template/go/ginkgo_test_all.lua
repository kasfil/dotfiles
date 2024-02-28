local overseer = require "overseer"

return {
  name = "Ginkgo Run",
  desc = "Run ginkgo tests",
  builder = function(params)
    return {
      cmd = { "ginkgo" },
      args = { "run", params.pkg },
      name = "Ginkgo: run all test",
      cwd = vim.fn.getcwd(),
    }
  end,

  tags = { overseer.TAG.TEST },
  params = {
    pkg = {
      type = "string",
      name = "dir or package",
      desc = "Dir or package name to test",
      order = 1,
      default = "./...",
      optional = false,
    },
  },
  condition = {
    filetype = { "go" },
  },
}
