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
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local cmp = require "cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    npairs.add_rules {
      Rule("<", ">", { "rust", "rs" }),
      Rule("|", "|", { "rust", "rs" }):with_pair(cond.before_text "("):with_move(cond.done()),
    }
  end,
}
