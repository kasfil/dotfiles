local tag = require("overseer.constants").TAG

return {
  name = "django_test",
  desc = "Run django test",
  builder = function()
    return {
      cmd = { "python" },
      args = { "manage.py", "test" },
      name = "django: run test",
      cwd = vim.fn.getcwd(),
      component = { "default" },
    }
  end,
  tags = { tag.TEST },
  condition = {
    callback = function() return vim.fn.filereadable "manage.py" == 1 end,
  },
}
