local overseer = require "overseer"

return {
  name = "Go run test",
  desc = "Run go test",
  builder = function(params)
    return {
      cmd = { "go" },
      args = { "test", params.pkg },
      name = "go: run test",
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
