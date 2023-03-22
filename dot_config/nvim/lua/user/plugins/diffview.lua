return {
  "sindrets/diffview.nvim",
  lazy = false,
  event = "BufReadPost",
  opts = {
    enhanced_diff_view = true,
    hooks = {
      view_opened = function(_) vim.opt_local.equalalways = true end,
    },
  }
}
