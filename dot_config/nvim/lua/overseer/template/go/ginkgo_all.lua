local overseer = require "overseer"
return {
  name = "Ginkgo Run All",
  desc = "Run all ginkgo tests",
  builder = function()
    return {
      cmd = { "ginkgo" },
      args = { "run", "./..." },
      name = "ginkgo: run all test",
      cwd = vim.fn.getcwd(),
    }
  end,

  tags = { overseer.TAG.TEST },
  condition = {
    filetype = { "go" },
    callback = function() return vim.fn.executable "ginkgo" == 1 end,
  },
}
