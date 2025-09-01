-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  -- Optional dependency
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    local npairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"
    local cond = require "nvim-autopairs.conds"

    npairs.setup {}
    npairs.add_rules {
      Rule("<", ">", { "rust", "rs" }):with_move(cond.done()),
      Rule("|", "|", { "rust", "rs" }):with_move(cond.done()),
    }
  end,
}
