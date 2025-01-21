---@type LazySpec
return {
  "stevearc/overseer.nvim",
  dependencies = { { "stevearc/dressing.nvim", lazy = true } },
  cmd = {
    "OverseerOpen",
    "OverseerToggle",
    "OverseerRunCmd",
    "OverseerRun",
    "OverseerBuild",
  },
  ---@module "overseer"
  ---@type overseer.Config
  opts = {
    form = {
      border = "single",
    },
    confirm = {
      border = "single",
    },
    task_win = {
      border = "single",
    },
  },
}
