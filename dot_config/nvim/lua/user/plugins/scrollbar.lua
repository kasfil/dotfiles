return {
  "petertriho/nvim-scrollbar",
  enable = false,
  lazy = false,
  event = { "BufReadPre" },
  opts = {
    set_highlights = true,
    excluded_buftypes = {
      "terminal",
      "nofile",
    },
    excluded_filetypes = {
      "prompt",
      "TelescopePrompt",
      "neo-tree",
      "aerial",
      "Trouble",
      "dap-repl",
      "packer",
      "qf",
      "toggleterm",
    },
    handlers = {
      gitsigns = true,
    },
    handle = {
      highlight = "ScrollbarHandle",
      hide_if_all_visible = false,
    },
    marks = {
      Cursor = { text = "■", highlight = "Normal" },
    },
  },
}
