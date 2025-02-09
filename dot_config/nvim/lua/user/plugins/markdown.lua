return {
  "OXY2DEV/markview.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    markdown = {
      tables = {
        parts = {
          top = { "┌", "─", "┐", "┬" },
          header = { "│", "│", "│" },
          separator = { "├", "─", "┤", "┼" },
          row = { "│", "│", "│" },
          bottom = { "└", "─", "┘", "┴" },

          overlap = { "├", "─", "┤", "┼" },

          align_left = "╼",
          align_right = "╾",
          align_center = { "╴", "╶" },
        },
        block_decorator = false,
        use_virt_lines = false,
      },
    },
  },
  -- config = function(_, opts)
  --   require("markview").setup(opts)
  -- end,
}
