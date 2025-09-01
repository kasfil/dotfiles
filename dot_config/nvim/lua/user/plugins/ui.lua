---@type LazySpec[]
return {
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPre" },
    dependencies = { "kevinhwang91/promise-async" },
    opts = {},
  },
  {
    "luukvbaal/statuscol.nvim",
    event = "VimEnter",
    config = function()
      local builtin = require "statuscol.builtin"
      require("statuscol").setup {
        relculright = true,
        ft_ignore = { "NvimTree", "sagaoutline", "fugitive" },
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
            text = { " " },
            condition = { true, builtin.not_empty },
          },
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
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    opts = function()
      local palette = vim.g.override_palette
      local base_bg = palette.bg_dim[1]
      local tab_bg = palette.bg1[1]
      local fg_active = palette.fg0[1]
      local fg_passive = palette.bg5[1]

      return {
        options = {
          numbers = "none",
          themable = true,
          close_command = function(bufnum) MiniBufremove.delete(bufnum, false) end,
          right_mouse_command = function(bufnum) MiniBufremove.delete(bufnum, false) end,
          left_mouse_command = "buffer %d",
          tab_size = 27,
          indicator = {
            style = "icon",
            icon = "🮘",
          },
          groups = {
            items = {
              require("bufferline.groups").builtin.pinned:with { icon = "󰐃 " },
            },
          },
          offsets = {
            {
              filetype = "NvimTree",
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
            local icon, hl, _ = MiniIcons.get("filetype", element.filetype)
            return icon, hl
          end,
          separator_style = { "▌", "▌" },
        },
        highlights = {
          fill = { bg = base_bg },
          background = {
            fg = fg_passive,
            bg = tab_bg,
          },
          buffer_selected = {
            fg = fg_active,
            bg = tab_bg,
            italic = false,
            bold = true,
          },
          buffer_visible = {
            fg = fg_active,
            bg = tab_bg,
            italic = false,
            bold = true,
          },
          tab = {
            fg = fg_passive,
            bg = tab_bg,
            italic = false,
            bold = true,
          },
          separator = {
            fg = tab_bg,
            bg = base_bg,
          },
          close_button = {
            fg = palette["bg5"][1],
            bg = tab_bg,
          },
          close_button_visible = {
            fg = palette["red"][1],
            bg = tab_bg,
          },
          close_button_selected = {
            fg = palette["red"][1],
            bg = tab_bg,
          },
          modified = {
            fg = palette["yellow"][1],
            bg = tab_bg,
          },
          modified_visible = {
            fg = palette["yellow"][1],
            bg = tab_bg,
          },
          modified_selected = {
            fg = palette["yellow"][1],
            bg = tab_bg,
          },
          pick = {
            fg = palette["red"][1],
            bg = tab_bg,
            italic = false,
          },
          pick_visible = {
            fg = palette["red"][1],
            bg = tab_bg,
            italic = false,
          },
          pick_selected = {
            fg = palette["red"][1],
            bg = tab_bg,
            italic = false,
          },
          duplicate = {
            fg = fg_passive,
            bg = tab_bg,
          },
          duplicate_selected = {
            fg = fg_active,
            bg = tab_bg,
            italic = false,
            bold = true,
          },
          duplicate_visible = {
            fg = fg_active,
            bg = tab_bg,
            italic = false,
            bold = true,
          },
          indicator_visible = {
            fg = palette.yellow[1],
            bg = tab_bg,
          },
          indicator_selected = {
            fg = palette.yellow[1],
            bg = tab_bg,
          },
        },
      }
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    event = { "VeryLazy" },
    lazy = true,
    keys = {
      { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle Filetree", noremap = true },
      { "<leader>o", "<Cmd>NvimTreeFocus<CR>", desc = "Focus Filetree", noremap = true },
    },
    opts = {
      view = { width = 30 },
      renderer = {
        group_empty = true,
        indent_width = 1,
      },
      filters = { dotfiles = true },
    },
  },
}
