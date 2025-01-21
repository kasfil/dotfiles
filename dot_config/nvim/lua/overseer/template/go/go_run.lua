return {
  name = "go run",
  builder = function()
    return {
      cmd = "go",
      args = { "run", "." },
      cwd = vim.fn.getcwd(),
      name = "go run",
      components = {
        { "on_output_quickfix", set_diagnostics = true, open = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
  desc = "Run project",
  condition = {
    filetype = { "go" },
  },
}
