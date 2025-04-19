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
        tab_char = "║",
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
    config = function(_, opts)
      local notify = require "notify"
      notify.setup(opts)

      -- attemp to replace neovim default notification
      vim.notify = notify
    end,
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    opts = function()
      local palette = vim.g.override_palette
      local base_bg = palette.bg0[1]
      local bg_active = palette.bg_visual_blue[1]
      local fg_active = palette.fg0[1]
      local bg_passive = palette.bg1[1]
      local fg_passive = palette.bg5[1]

      return {
        options = {
          numbers = "none",
          themable = true,
          close_command = function(bufnum) _G.MiniBufremove.delete(bufnum, false) end,
          right_mouse_command = function(bufnum) _G.MiniBufremove.delete(bufnum, false) end,
          left_mouse_command = "buffer %d",
          indicator = {
            style = "none",
          },
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
            {
              filetype = "dap-repl",
              text = "Debug REPL",
              text_align = "center",
              separator = true,
            },
            {
              filetype = "aerial",
              text = "Aerial Outline",
              text_align = "center",
              separator = true,
            },
            {
              filetype = "dbui",
              text = "Dadbod UI",
              text_align = "center",
              separator = true,
            },
          },
          color_icons = true,
          get_element_icon = function(element)
            local icon, hl, _ = _G.MiniIcons.get("filetype", element.filetype)
            return icon, hl
          end,
          separator_style = "slope",
        },
        highlights = {
          fill = { bg = base_bg },
          background = {
            fg = fg_passive,
            bg = bg_passive,
          },
          buffer_selected = {
            fg = fg_active,
            bg = bg_active,
            italic = false,
            bold = true,
          },
          buffer_visible = {
            fg = fg_active,
            bg = bg_active,
            italic = false,
            bold = true,
          },
          tab = {
            fg = fg_passive,
            bg = bg_passive,
            italic = false,
            bold = true,
          },
          separator = {
            bg = bg_passive,
            fg = base_bg,
          },
          separator_selected = {
            bg = bg_active,
            fg = base_bg,
          },
          separator_visible = {
            bg = bg_active,
            fg = base_bg,
          },
          close_button = {
            fg = palette["bg5"][1],
            bg = bg_passive,
          },
          close_button_visible = {
            fg = palette["red"][1],
            bg = bg_active,
          },
          close_button_selected = {
            fg = palette["red"][1],
            bg = bg_active,
          },
          modified = {
            fg = palette["yellow"][1],
            bg = bg_passive,
          },
          modified_visible = {
            fg = palette["yellow"][1],
            bg = bg_active,
          },
          modified_selected = {
            fg = palette["yellow"][1],
            bg = bg_active,
          },
        },
      }
    end,
  },
}
