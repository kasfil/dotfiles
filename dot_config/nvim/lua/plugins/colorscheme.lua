return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = function()
      -- bg        = "#282c34", fg      = "#abb2bf", red    = "#e06c75",
      -- orange    = "#d19a66", yellow  = "#e5c07b", green  = "#98c379",
      -- cyan      = "#56b6c2", blue    = "#61afef", purple = "#c678dd",
      -- white     = "#abb2bf", black   = "#282c34", gray   = "#5c6370",
      -- highlight = "#e2be7d", comment = "#7f848e", none   = "NONE",

      local helper = require "onedarkpro.helpers"
      local colors = helper.get_preloaded_colors()

      return {
        styles = {
          comments = "italic",
        },
        options = {
          terminal_colors = true,
        },
        colors = {
          dim_bg = helper.darken("bg", 1, "onedark"),
          dark_bg = helper.darken("bg", 3, "onedark"),
          darker_bg = helper.darken("bg", 5, "onedark"),
        },
        highlights = {
          NormalNC = { bg = "${dim_bg}" },
          LineNr = { bg = "none" },
          SignColumn = { bg = "none" },
          FoldColumn = { bg = "none" },

          CursorLine = { bg = "none" },
          CursorLineNr = { bg = "none", fg = colors.green },

          CmpFloatBorder = { bg = "none", fg = "none" },

          NonText = { bg = "none", fg = helper.brighten("bg", 5, "onedark") },

          IndentBlanklineChar = { fg = helper.lighten("bg", 1, "onedark") },
          IndentBlanklineContextChar = { fg = helper.lighten("bg", 20, "onedark") },

          DiagnosticUnderlineError = { fg = "none", sp = colors.red, undercurl = true },
          DiagnosticUnderlineWarn = { fg = "none", sp = colors.yellow, undercurl = true },
          DiagnosticUnderlineInfo = { fg = "none", sp = colors.blue, undercurl = true },
          DiagnosticUnderlineHint = { fg = "none", sp = colors.cyan, undercurl = true },

          StatusTabSize = { fg = colors.yellow },
          StatusGitRemoteUnsync = { fg = colors.yellow },
          StatusGitRemoteSync = { fg = colors.green },
          BufferPathActive = { fg = colors.green },

          WinSeparator = { bg = colors.bg, fg = "${dark_bg}" },
          FloatBorder = { fg = "${dark_bg}", bg = "${dark_bg}" },

          SatelliteCursor = {
            fg = helper.lighten("bg", 30, "onedark"),
            bg = helper.lighten("bg", 30, "onedark"),
          },

          WindowPickerWinBar = { bg = colors.green, fg = colors.bg, bold = true },
          WindowPickerWinBarNC = { bg = colors.blue, fg = colors.bg, bold = true },
          WindowPickerStatusLine = { link = "WindowPickerWinBar" },
          WindowPickerStatusLineNC = { link = "WindowPickerWinBarNC" },

          TelescopeNormal = { bg = "${dark_bg}" },
          TelescopeBorder = { bg = "${dark_bg}", fg = "${dark_bg}" },
          TelescopePreviewTitle = { bg = colors.orange, fg = colors.bg, bold = true },
          TelescopePromptNormal = { bg = "${darker_bg}" },
          TelescopePromptBorder = {
            bg = "${darker_bg}",
            fg = "${darker_bg}",
          },
          TelescopePromptTitle = { bg = colors.yellow, fg = colors.bg },
          TelescopePromptCounter = { fg = colors.green },

          SideWin = { fg = colors.fg, bg = "${darker_bg}" },
          NeotreeNormal = { link = "SideWin" },
          NeotreeNormalNC = { link = "SideWin" },
          TroubleNormal = { link = "SideWin" },

          LeapBackdrop = { fg = colors.comment },
          WinBar = { bg = "${darker_bg}" },
          WinBarNC = { bg = "${dark_bg}" },
          WinBarFile = { fg = colors.blue, bg = "${darker_bg}" },
          WinBarFileIcon = { fg = colors.green, bg = "${darker_bg}" },
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function(_, _)
      -- rosewater = "#F4DBD6", flamingo = "#F0C6C6", pink     = "#F5BDE6",
      -- mauve     = "#C6A0F6", red      = "#ED8796", maroon   = "#EE99A0",
      -- peach     = "#F5A97F", yellow   = "#EED49F", green    = "#A6DA95",
      -- teal      = "#8BD5CA", sky      = "#91D7E3", sapphire = "#7DC4E4",
      -- blue      = "#8AADF4", lavender = "#B7BDF8", text     = "#CAD3F5",
      -- subtext1  = "#B8C0E0", subtext0 = "#A5ADCB", overlay2 = "#939AB7",
      -- overlay1  = "#8087A2", overlay0 = "#6E738D", surface2 = "#5B6078",
      -- surface1  = "#494D64", surface0 = "#363A4F", base     = "#24273A",
      -- mantle    = "#1E2030", crust    = "#181926",

      local p = require("catppuccin.palettes").get_palette "macchiato"
      local u = require "catppuccin.utils.colors"

      return {
        flavour = "macchiato",
        term_colors = false,
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
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
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
