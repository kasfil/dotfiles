return {
  "folke/which-key.nvim",
  lazy = false,
  opts = function(_, opts)
    opts.window = { border = "none", padding = { 4, 4, 4, 4 } }
    opts.spelling = { enabled = true }
    opts.layout = {
      width = { min = 30, max = 55 },
      spacing = 7,
      align = "center",
    }
    return opts
  end,
}
