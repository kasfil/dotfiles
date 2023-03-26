local wezterm = require("wezterm")

return {
  color_scheme = "Catppuccin Macchiato",
  enable_wayland = false,
  default_prog = { "/bin/bash" },

  font = wezterm.font_with_fallback({
    {family = "JetBrains Mono", harfbuzz_features = {"zero=1", "cv06=1"}},
    {family = "Symbols Nerd Fonts"},
    {family = "Hack Nerd Font"},
  }),

  font_size = 10,

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,

  window_decorations = "NONE",
}
