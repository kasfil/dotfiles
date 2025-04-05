local wezterm = require "wezterm"
local action = wezterm.action
local smart_splits = wezterm.plugin.require "https://github.com/mrjones2014/smart-splits.nvim"
local gpus = wezterm.gui.enumerate_gpus()

local config = {
  enable_wayland = false,
  default_prog = { "/bin/bash" },

  font = wezterm.font_with_fallback {
    { family = "JetBrainsMono NFP", harfbuzz_features = { "ss19=1", "cv06=1", "cv07=1", "zero=1", "calt=0" } },
    { family = "Symbols Nerd Font" },
    { family = "Noto Color Emoji", assume_emoji_presentation = true },
  },

  font_size = 10,
  line_height = 1.1,
  cell_width = 1,

  animation_fps = 1,

  anti_alias_custom_block_glyphs = false,
  freetype_load_target = "HorizontalLcd",

  front_end = "OpenGL",
  webgpu_preferred_adapter = gpus[1],
  webgpu_power_preference = "HighPerformance",

  unicode_version = 14,

  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,

  window_decorations = "NONE",
  initial_rows = 35,
  initial_cols = 115,

  use_cap_height_to_scale_fallback_fonts = false,
  audible_bell = "Disabled",

  -- disable window close confirmation
  window_close_confirmation = "NeverPrompt",

  color_scheme = "mute-session",
  color_schemes = {
    ["gruvbox_material_dark_hard"] = {
      foreground = "#D4BE98",
      background = "#1D2021",
      cursor_bg = "#D4BE98",
      cursor_border = "#D4BE98",
      cursor_fg = "#1D2021",
      selection_bg = "#D4BE98",
      selection_fg = "#3C3836",

      ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
      brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
    },
    ["mute-session"] = {
      background = "#181818", -- Matches `bg0`
      foreground = "#B9AB8F", -- Matches `fg0`
      cursor_bg = "#C4B69A", -- Matches `fg1`
      cursor_fg = "#181818", -- Cursor text (inverse of bg0)
      cursor_border = "#C4B69A", -- Cursor outline color

      --  Selection Colors
      selection_bg = "#383634", -- Matches `bg4`
      selection_fg = "#B9AB8F", -- Matches `fg0`

      --  Normal Colors (Matching Syntax Colors)
      ansi = {
        "#181818", -- Black (bg0)
        "#C56F6B", -- Red (Keywords, Errors)
        "#9A9F72", -- Green (Strings, Success Messages)
        "#B89D6B", -- Yellow (Constants, Parameters)
        "#7B9590", -- Blue (Types, Class Names)
        "#A88995", -- Purple (Control Flow)
        "#6F8A7E", -- Cyan (Imports, Special Types)
        "#B9AB8F", -- White (fg0)
      },

      -- 🎨 Bright Colors
      brights = {
        "#252525", -- Bright Black (bg2)
        "#D27C7A", -- Bright Red (Modified)
        "#A8A97E", -- Bright Green
        "#C7AA7B", -- Bright Yellow
        "#8AA5A0", -- Bright Blue
        "#B48E9F", -- Bright Purple
        "#7E998B", -- Bright Cyan
        "#C4B69A", -- Bright White (fg1)
      },

      -- ⚡ Visual Mode, Diff & Git Colors
      indexed = {
        [17] = "#16252A", -- bg_diff_blue
        [35] = "#1F2617", -- bg_diff_green
        [52] = "#2A1B1C", -- bg_diff_red
        [233] = "#253233", -- bg_visual_blue
        [34] = "#2A332C", -- bg_visual_green
        [136] = "#3A3325", -- bg_visual_yellow
      },

      compose_cursor = "#B89D6B",
    },
  },

  leader = { key = "/", mods = "CTRL", timeout_milliseconds = 1000 },

  keys = {
    {
      key = "z",
      mods = "LEADER",
      action = action.TogglePaneZoomState,
    },
    {
      key = "w",
      mods = "LEADER",
      action = action.CloseCurrentPane { confirm = true },
    },
    {
      key = "W",
      mods = "LEADER|SHIFT",
      action = action.CloseCurrentTab { confirm = true },
    },
    {
      key = "-",
      mods = "LEADER|CTRL",
      action = action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = "|",
      mods = "LEADER|CTRL|SHIFT",
      action = action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
  },
}

smart_splits.apply_to_config(config, {
  direction_keys = {
    move = { "h", "j", "k", "l" },
    resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
  },
  modifiers = { move = "CTRL", resize = "CTRL" },
  log_level = "error",
})

local ok, companion = pcall(require, "companion")
if ok then companion.apply_config(config) end

return config
