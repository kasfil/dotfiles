local server_config = require("astronvim.utils.lsp").config

return {
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "folke/neoconf.nvim" },
    ft = { "rust" },
    opts = {
      server = server_config "rust_analyzer",
      tools = {
        inlay_hints = { auto = false },
        hover_actions = {
          max_width = 120,
          max_height = 35,
        },
      },
    },
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml", "BufRead Cargo.lock" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        src = { cmp = { enabled = true } },
      }
    end,
  },
}
