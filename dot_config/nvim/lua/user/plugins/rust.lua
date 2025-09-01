return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    ft = { "rust", "rs" },
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          code_actions = {
            group_icon = require("user.utils").get_icon "telescope_select_caret",
          },
        },
      }
    end,
    lazy = false,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
        name = "crates.nvim",
      },
    },
  },
}
