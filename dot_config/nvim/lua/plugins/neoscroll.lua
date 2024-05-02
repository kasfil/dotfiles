return {
  "karb94/neoscroll.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = function() return not vim.g.neovide end,
  config = function() require("neoscroll").setup {} end,
}
