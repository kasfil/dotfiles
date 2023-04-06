return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = function(_, _)
    local p = require("catppuccin.palettes").get_palette "macchiato"
    local u = require "catppuccin.utils.colors"

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

    return {
      flavour = "macchiato",
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.75,
      },
      custom_highlights = {
        NonText = { fg = u.lighten(p.surface0, 1, p.surface0) },
        WinSeparator = { bg = p.base, fg = p.base },
        FloatBorder = { fg = p.overlay2, bg = p.mantle },

        DiffDelete = {
          bg = u.darken(p.red, 0.09, p.base),
          fg = p.surface1,
          style = { "bold" },
        },

        IndentBlanklineChar = { fg = u.darken(p.surface0, 0.5, p.base) },
        IndentBlanklineContextChar = { fg = u.blend(p.pink, p.base, 0.5) },

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

        CmpFloatBorder = { link = "FloatBorder" },

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
      },
      styles = {
        comments = {},
        conditionals = {},
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
}
