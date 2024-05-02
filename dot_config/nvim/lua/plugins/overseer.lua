return {
  "stevearc/overseer.nvim",
  lazy = true,
  cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction", "OverseerRestartLast" },
  keys = {
    { "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run" },
    { "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle" },
    { "<leader>ra", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
    { "<leader>rl", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last" },
  },
  module = true,
  opts = function(opts)
    opts.templates = {
      "builtin",
      "django.test",
      "go.ginkgo_all",
      "go.ginkgo_package",
      "go.go_test_all",
      "go.go_test_package",
    }
  end,
  config = function(opts)
    local overseer = require "overseer"
    local create_user_cmd = vim.api.nvim_create_user_command

    overseer.setup(opts)

    create_user_cmd("OverseerRestartLast", function()
      local tasks = overseer.list_tasks { recent_first = true }

      if vim.tbl_isempty(tasks) then
        vim.notify("No tasks found", vim.log.levels.WARN)
      else
        overseer.run_action(tasks[1], "restart")
      end
    end, {})
  end,
}
