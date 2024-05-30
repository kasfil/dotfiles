-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        [[                                            ]],
        [[ ┳    ┓      ┓                  ┓      ┓    ]],
        [[ ┃╋┏  ┣┓┏┓┏┓┏┫┏┓┏┓  ╋┏┓  ┏┓┏┓┏┓┏┫  ┏┏┓┏┫┏┓  ]],
        [[ ┻┗┛  ┛┗┗┻┛ ┗┻┗ ┛   ┗┗┛  ┛ ┗ ┗┻┗┻  ┗┗┛┗┻┗ ╻ ]],
        [[         ┓                 •     •          ]],
        [[        ╋┣┓┏┓┏┓  ╋┏┓  ┓┏┏┏┓┓╋┏┓  ┓╋         ]],
        [[        ┗┛┗┗┻┛┗  ┗┗┛  ┗┻┛┛ ┗┗┗   ┗┗         ]],
        [[                                            ]],
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  { "kevinhwang91/nvim-ufo", version = false, branch = "main", dependencies = "kevinhwang91/promise-async" },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost" },
    main = "ibl",
    opts = function(_, opts)
      opts.indent.char = "│"
      opts.indent.tab_char = "│"
      opts.scope.char = "┃"
      opts.scope.highlight = { "IndentBlanklineContextChar" }
    end,
  },

  {
    "tenxsoydev/karen-yank.nvim",
    event = { "VimEnter" },
    config = true,
  },

  {
    "mrjones2014/smart-splits.nvim",
    event = { "VimEnter" },
    cond = function() return not vim.g.neovide end,
  },

  {
    "ray-x/lsp_signature.nvim",
    lazy = false,
    event = { "InsertEnter" },
    opts = function()
      return {
        debug = false,
        hint_prefix = "",
        handler_opt = {
          border = "single",
        },
        trigger_on_newline = true,
        padding = " ",
        toggle_key = "<M-x>",
      }
    end,
  },

  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "folke/trouble.nvim",
        opts = {
          use_diagnostic_signs = true,
        },
      },
    },
    event = "BufReadPre",
    opts = {
      keywords = {
        TEST = { alt = { "TESTING", "PASSED" } },
      },
    },
  },

  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "InsertEnter" },
    version = "*",
    config = function() require("nvim-surround").setup() end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      render = "compact",
      stages = "slide",
      timeout = 1500,
    },
  },

  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    config = function() require("mini.align").setup() end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    "numToStr/Comment.nvim",
    enabled = false,
  },

  {
    "folke/zen-mode.nvim",
    opts = function(_, opts)
      local old_on_open = opts.on_open
      local old_on_close = opts.on_close

      opts.on_open = function()
        old_on_open()
        vim.cmd "SatelliteDisable"
      end

      opts.on_close = function()
        old_on_close()
        vim.cmd "SatelliteEnable"
      end
    end,
  },

  {
    "ray-x/go.nvim",
    version = false,
    branch = "master",
  },
}
