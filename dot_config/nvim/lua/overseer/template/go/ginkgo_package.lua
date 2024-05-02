local overseer = require "overseer"
return {
  name = "Ginkgo Run Package Test",
  desc = "Run ginkgo tests in the current package",
  builder = function()
    return {
      cmd = { "ginkgo" },
      args = {
        "run",
        function()
          local filePath = vim.fn.expand "%:p"
          return vim.fn.fnamemodify(filePath, ":h:~:t")
        end,
      },
      name = "ginkgo: run package test",
      cwd = vim.fn.getcwd(),
    }
  end,

  tags = { overseer.TAG.TEST },
  condition = {
    filetype = { "go" },
    callback = function() return vim.fn.executable "ginkgo" == 1 end,
  },
}
