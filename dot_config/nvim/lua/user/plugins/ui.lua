---@type LazySpec[]
return {
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost" },
    dependencies = { "kevinhwang91/promise-async" },
    opts = {},
  },
  {
    "lewis6991/satellite.nvim",
    event = { "VeryLazy" },
    opts = {
      excluded_filetypes = {
        "neo-tree",
        "aerial",
        "dbui",
        "dbout",
        "fugitive",
        "blame",
        "gitsigns-blame",
        "fugitiveblame",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "qf",
        "grug-far",
        "dap-float",
        "dap-repl",
        "lspinfo",
      },
    },
  },
  {
    "luukvbaal/statuscol.nvim",
    event = "VimEnter",
    config = function()
      local builtin = require "statuscol.builtin"
      require("statuscol").setup {
        relculright = true,
        ft_ignore = { "neo-tree", "sagaoutline", "fugitive" },
        bt_ignore = { "nofile" },
        segments = {
          {
            sign = {
              name = { ".*" },
              namespace = { "diagnostic/signs" },
              maxwidth = 1,
              colwidth = 2,
              auto = false,
            },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          {
            sign = {
              namespace = { "gitsigns" },
              maxwidth = 1,
              colwidth = 1,
              auto = false,
            },
            click = "v:lua.ScSa",
          },
          {
            text = { builtin.foldfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScFa",
          },
        },
      }
    end,
  },
  -- ┳ ╻   ┓      ┓                  ┓      ┓
  -- ┃╋ ┏  ┣┓┏┓┏┓┏┫┏┓┏┓  ╋┏┓  ┏┓┏┓┏┓┏┫  ┏┏┓┏┫┏┓
  -- ┻┗ ┛  ┛┗┗┻┛ ┗┻┗ ┛   ┗┗┛  ┛ ┗ ┗┻┗┻  ┗┗┛┗┻┗ ╻
  --          ┓                 •     •
  --         ╋┣┓┏┓┏┓  ╋┏┓  ┓┏┏┏┓┓╋┏┓  ┓╋
  --         ┗┛┗┗┻┛┗  ┗┗┛  ┗┻┛┛ ┗┗┗   ┗┗•
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost" },
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        highlight = "IblIndent",
        char = "▏",
        tab_char = "╎",
      },
      scope = {
        enabled = true,
        highlight = { "IblScope" },
        show_start = false,
        show_end = false,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = { render = "wrapped-compact" },
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}
