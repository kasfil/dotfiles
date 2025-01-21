local wezterm = require("wezterm")
local action = wezterm.action
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local config = {
  enable_wayland = false,
  default_prog = { "/bin/bash" },

  font = wezterm.font_with_fallback({
    { family = "IntoneMono NFP" },
    -- { family = "0xProto", harfbuzz_features = { "ss01=1", "calt=0", "dlig=0", "liga=0" } },
    -- { family = "JetBrains Mono", harfbuzz_features = { "ss19=1", "zero=1", "cv06=1", "cv07=1" } },
    { family = "Symbols Nerd Font" },
    -- { family = "OpenMoji", assume_emoji_presentation = true },
    { family = "Noto Color Emoji", assume_emoji_presentation = true },
  }),

  font_size = 12,
  -- line_height = 1.1,

  unicode_version = 14,

  dpi = 96,

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

  color_scheme = "gruvbox_material_dark_hard",
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
      action = action.CloseCurrentPane({ confirm = true }),
    },
    {
      key = "W",
      mods = "LEADER|SHIFT",
      action = action.CloseCurrentTab({ confirm = true }),
    },
    {
      key = "-",
      mods = "LEADER|CTRL",
      action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "|",
      mods = "LEADER|CTRL|SHIFT",
      action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
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

return config
