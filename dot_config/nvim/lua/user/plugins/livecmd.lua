return {
  "smjonas/live-command.nvim",
  event = "BufReadPost",
  opts = {
    commands = {
      Norm = { cmd = "norm" },
    },
  },
  config = function(_, opts) require("live-command").setup(opts) end,
}
