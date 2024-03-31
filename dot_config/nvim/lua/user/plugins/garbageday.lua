return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    excluded_lsp_clients = {
      "none-ls",
    },
    grace_period = 60 * 3,
  },
}
