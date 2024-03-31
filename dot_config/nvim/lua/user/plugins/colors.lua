return {
  {
    "Alexis12119/nightly.nvim",
    lazy = false,
    opts = function(_, _)
      local p = require("nightly.palette").dark_colors

      -- color0 = "#232A2D",
      -- color1 = "#E57474",
      -- color2 = "#8CCF7E",
      -- color3 = "#E5C76B",
      -- color4 = "#67B0E8",
      -- color5 = "#C47FD5",
      -- color6 = "#6CBFBF",
      -- color7 = "#B3B9B8",
      -- color8 = "#2D3437",
      -- color9 = "#EF7E7E",
      -- color10 = "#96D988",
      -- color11 = "#F4D67A",
      -- color12 = "#71BAF2",
      -- color13 = "#CE89DF",
      -- color14 = "#67CBE7",
      -- color15 = "#BDC3C2",
      -- color16 = "#0F1416",
      -- color17 = "#5A5D61",
      -- color18 = "#292E42",
      -- comment = "#404749",
      -- black = "#000000",
      -- background = "#141B1E",
      -- foreground = "#DADADA",
      -- cursorline = "#242e32",
      -- none = "NONE",

      return {
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
        highlights = {
          NonText = { link = "Comment" },
          BufferBarActive = { fg = p.foreground, bg = "#242e32" },

          IndentBlanklineContextChar = { fg = p.color15 },
          IndentBlanklineSpaceChar = { fg = p.none },
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, _)
      -- rosewater = "#F4DBD6",
      -- flamingo = "#F0C6C6",
      -- pink = "#F5BDE6",
      -- mauve = "#C6A0F6",
      -- red = "#ED8796",
      -- maroon = "#EE99A0",
      -- peach = "#F5A97F",
      -- yellow = "#EED49F",
      -- green = "#A6DA95",
      -- teal = "#8BD5CA",
      -- sky = "#91D7E3",
      -- sapphire = "#7DC4E4",
      -- blue = "#8AADF4",
      -- lavender = "#B7BDF8",
      -- text = "#CAD3F5",
      -- subtext1 = "#B8C0E0",
      -- subtext0 = "#A5ADCB",
      -- overlay2 = "#939AB7",
      -- overlay1 = "#8087A2",
      -- overlay0 = "#6E738D",
      -- surface2 = "#5B6078",
      -- surface1 = "#494D64",
      -- surface0 = "#363A4F",
      -- base = "#24273A",
      -- mantle = "#1E2030",
      -- crust = "#181926",

      local p = require("catppuccin.palettes").get_palette "macchiato"
      local u = require "catppuccin.utils.colors"

      return {
        flavour = "macchiato",
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.75,
        },
        custom_highlights = {
          NonText = { fg = u.lighten(p.surface0, 1, p.surface0) },
          WinSeparator = { bg = p.base, fg = p.base },
          FloatBorder = { fg = p.mantle, bg = p.mantle },

          DiffDelete = {
            bg = u.darken(p.red, 0.09, p.base),
            fg = p.surface1,
            style = { "bold" },
          },

          IndentBlanklineChar = { fg = u.darken(p.surface0, 0.5, p.base) },
          IndentBlanklineContextChar = { fg = u.blend(p.pink, p.base, 0.5) },

          SatelliteCursor = { fg = p.peach, bg = p.peach },

          WinSelect = { bg = p.yellow, fg = p.mantle },

          LeapBackdrop = { fg = p.overlay2 },
          WinBar = { bg = p.mantle },
          WinBarFile = { fg = p.teal, bg = p.mantle },
          WinBarFileIcon = { fg = p.peach, bg = p.mantle },

          GitSignsCurrentLineBlame = { fg = p.subtext0 },
          SideWin = { fg = p.text, bg = p.mantle },
          NeotreeNormal = { link = "SideWin" },
          NeotreeNormalNC = { link = "SideWin" },
          TroubleNormal = { link = "SideWin" },

          DapStatusLine = { fg = p.maroon, bg = p.surface0 },

          ScrollbarHandle = { bg = u.darken(p.lavender, 0.15, p.base) },
          ScrollbarCursorHandle = { fg = p.peach, bg = p.peach },
          ScrollbarCursor = { fg = p.peach, bg = p.peach },

          TabLineSel = { fg = p.text, bg = p.red },
          BufferBarActive = { fg = p.foreground, bg = p.crust },

          TelescopeNormal = { bg = p.mantle },
          TelescopeBorder = { bg = p.mantle, fg = p.mantle },
          TelescopePreviewTitle = { bg = p.maroon, fg = p.base },
          TelescopePromptNormal = { bg = u.darken(p.surface0, 0.5, p.base) },
          TelescopePromptBorder = {
            bg = u.darken(p.surface0, 0.5, p.base),
            fg = u.darken(p.surface0, 0.5, p.base),
          },
          TelescopePromptTitle = { bg = p.yellow, fg = p.base },
          TelescopePromptCounter = { fg = p.flamingo },

          WhichKeyBorder = { fg = p.crust, bg = p.crust },

          NotifyBackground = { bg = p.surface0, fg = p.text },
          NotifyERRORBorder = { fg = p.surface0, bg = p.surface0 },
          NotifyWARNBorder = { link = "NotifyERRORBorder" },
          NotifyINFOBorder = { link = "NotifyERRORBorder" },
          NotifyDEBUGBorder = { link = "NotifyERRORBorder" },
          NotifyTRACEBorder = { link = "NotifyERRORBorder" },
          NotifyERRORBody = { bg = p.surface0, fg = p.red },
          NotifyWARNBody = { bg = p.surface0, fg = p.yellow },
          NotifyINFOBody = { bg = p.surface0, fg = p.blue },
          NotifyDEBUGBody = { bg = p.surface0, fg = p.blue },
          NotifyTRACEBody = { bg = p.surface0, fg = p.text },
          NotifyERRORIcon = { link = "NotifyERRORBody" },
          NotifyWARNIcon = { link = "NotifyWARNBody" },
          NotifyINFOIcon = { link = "NotifyINFOBody" },
          NotifyDEBUGIcon = { link = "NotifyDEBUGBody" },
          NotifyTRACEIcon = { link = "NotifyTRACEBody" },
          NotifyERRORTitle = { link = "NotifyERRORBody" },
          NotifyWARNTitle = { link = "NotifyWARNBody" },
          NotifyINFOTitle = { link = "NotifyINFOBody" },
          NotifyDEBUGTitle = { link = "NotifyDEBUGBody" },
          NotifyTRACETitle = { link = "NotifyTRACEBody" },

          AlphaHeader = { bg = p.blue, fg = p.base },

          WindowPickerWinBar = { bg = p.green, fg = p.base },
          WindowPickerWinBarNC = { bg = p.blue, fg = p.base },
          WindowPickerStatusLine = { link = "WindowPickerWinBar" },
          WindowPickerStatusLineNC = { link = "WindowPickerWinBarNC" },
        },
        styles = {
          comments = { "italic" },
          conditionals = { "bold" },
        },
        integrations = {
          lsp_saga = true,
          mason = true,
          neotree = true,
          neotest = true,
          aerial = true,
          notify = false,
          fidget = false,
          which_key = true,
          symbols_outline = false,
          semantic_tokens = true,
          native_lsp = {
            virtual_text = {
              errors = {},
              hints = {},
              warnings = {},
              information = {},
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          lsp_trouble = true,
          leap = true,
          cmp = true,
          dap = {
            enabled = true,
            enable_ui = true,
          },
          gitsigns = true,
        },
      }
    end,
  },
}
