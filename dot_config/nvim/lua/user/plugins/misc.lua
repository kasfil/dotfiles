return {
  -- auto detect tabstop and shifwidth
  "tpope/vim-sleuth",
  "tpope/vim-fugitive",

  {
    "elubow/cql-vim",
    ft = { "cqlang", "cql" },
  },

  {
    "nmac427/guess-indent.nvim",
    event = { "BufReadPost" },
    opts = {},
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost" },
    config = function()
      require("illuminate").configure {
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
          "aerial",
          "NvimTree",
          "sagafinder",
          "sagatypehierarchy",
          "sagacallhierarchy",
          "sagadiagnostic",
        },
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
      local ft = require "Comment.ft"
      -- CQL comment string
      ft.cql = { "--%s", "/*%s*/" }
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      ignored_filetypes = { "neo%-tree" },
      log_level = "error",
    },
    config = true,
  },
  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    config = true,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost" },
    opts = {
      render = "background",
      virtual_symbol = "█",
    },
    config = function(_, opts)
      require("nvim-highlight-colors").setup {
        render = "background",
        enable_named_colors = false,
      }
      require("nvim-highlight-colors").turnOff()
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = { ---@class wk.Opts
      preset = "helix",
      delay = 0,
      win = {
        no_overlap = false,
        padding = { 2, 6 },
        height = { min = 1, max = 20 },
        border = "none",
      },
      layout = {
        width = { min = 30, max = 55 },
        spacing = 3,
      },
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      icons = {
        separator = "━",
        group = " 󱡠 ",
      },
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)

      -- Document existing key chains
      wk.add {
        { "<leader>s", group = "info", icon = " " },
        { "<leader>sq", group = "loclist", icon = "󱎻 " },
        { "gr", group = "LSP" },
      }

      wk.add(require "user.config.mapping")
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  {
    "MagicDuck/grug-far.nvim",
    event = "VeryLazy",
    command = "GrugFar",
    opts = {
      icons = {
        enabled = true,

        fileIconsProvider = "first_available",
        actionEntryBullet = " ",
        searchInput = " ",
        replaceInput = " ",
        filesFilterInput = " ",
        flagsInput = "󰮚 ",
        pathsInput = " ",

        resultsStatusReady = "󱩾 ",
        resultsStatusError = " ",
        resultsStatusSuccess = " ",
        resultsActionMessage = "  ",
        resultsEngineLeft = "⟪",
        resultsEngineRight = "⟫",
        resultsChangeIndicator = "┃",
        resultsAddedIndicator = "▒",
        resultsRemovedIndicator = "▒",
        resultsDiffSeparatorIndicator = "┊",
        historyTitle = "   ",
        helpTitle = " 󰘥  ",

        newline = " ",
      },
    },
    config = true,
  },

  {
    "MunifTanjim/nui.nvim",
    lazy = true,
    event = "VeryLazy",
  },

  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
