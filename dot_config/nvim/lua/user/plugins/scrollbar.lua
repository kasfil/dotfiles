if vim.fn.has "nvim-0.10" == 1 then
  return {
    "lewis6991/satellite.nvim",
    lazy = false,
    event = { "BufReadPre" },
    opts = {
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
        cursor = {
          symbols = { " " },
        },
      },
    },
  }
else
  return {
    "petertriho/nvim-scrollbar",
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
        Cursor = { text = " ", color = "#F5A97F" },
      },
    },
  }
end
