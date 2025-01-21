return {
  {
    "nvim-neotest/neotest",
    lazy = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "fredrikaverpil/neotest-golang",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "rustaceanvim.neotest",
          require "neotest-python" {
            dap = { justMyCode = true },
          },
          require "neotest-golang" {
            go_test_args = {
              "-v",
              "-race",
              "-count=1",
              "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
            },
          },
        },
        floating = {
          border = "single",
        },
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "┐",
          failed = "",
          final_child_indent = " ",
          final_child_prefix = "└",
          non_collapsible = "─",
          notify = "",
          passed = "",
          running = "",
          running_animated = { "⢹", "⢺", "⢼", "⣸", "⣇", "⡧", "⡗", "⡏" },
          skipped = "",
          unknown = "",
          watching = "",
        },
      }
    end,
  },
}
