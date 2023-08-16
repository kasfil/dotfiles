local server_config = require("astronvim.utils.lsp").config

return {
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "folke/neoconf.nvim" },
    ft = { "rust" },
    opts = {
      hover_actions = {
        border = "single",
      },
      server = server_config "rust_analyzer",
    },
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml", "BufRead Cargo.lock" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("crates").setup() end,
  },
}
