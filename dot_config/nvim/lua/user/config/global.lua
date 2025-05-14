vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.winborder = "single"

vim.g.override_palette = {
  -- stylua: ignore start
  bg_dim =           { "#121212", "16"  }, -- Darkest background (almost black)
  bg0 =              { "#181818", "16"  }, -- Main terminal background
  bg1 =              { "#202020", "234" }, -- Reference mid-dark background (unchanged)
  bg2 =              { "#252525", "234" }, -- Slightly brighter than `bg1`, but still subtle
  bg3 =              { "#2D2B2A", "235" }, -- Gentle step up for separation
  bg4 =              { "#383634", "236" }, -- More contrast for UI elements
  bg5 =              { "#464442", "237" }, -- Lightest background shade (borders, highlights)
  bg_current_word =  { "#2e2d2c", "238" },
  bg_statusline1 =   { "#252525", "234" },
  bg_statusline2 =   { "#2e2d2c", "238" },
  bg_statusline3 =   { "#484644", "236" },
  bg_diff_blue =     { "#16252A", "17"  }, -- Muted deep cyan-blue
  bg_diff_green =    { "#1F2617", "35"  }, -- Dark olive green
  bg_diff_red =      { "#2A1B1C", "52"  }, -- Deep reddish-brown
  bg_visual_blue =   { "#253233", "233" }, -- Soft desaturated teal
  bg_visual_green =  { "#2A332C", "34"  }, -- Muted forest green
  bg_visual_red =    { "#322526", "52"  }, -- Subtle warm brown-red
  bg_visual_yellow = { "#3A3325", "136" }, -- Warm earthy yellow
  bg_yellow =        { "#B89D6B", "178" },
  bg_green =         { "#9A9F72", "100" },
  bg_red =           { "#C56F6B", "160" },
  fg0 =              { "#B9AB8F", "136" }, -- Main text color (soft beige-tan)
  fg1 =              { "#C4B69A", "137" }, -- Brighter for subtle emphasis
  grey0 =            { "#9C9281", "101" }, -- Darker than `fg0`, but still neutral
  grey1 =            { "#8B8273", "103" }, -- More muted, used for less important text
  grey2 =            { "#7A7165", "105" }, -- Darkest gray for UI elements
  green =            { "#9A9F72", "100" },
  aqua =             { "#6F8A7E", "87"  },
  blue =             { "#7B9590", "87"  },
  orange =           { "#C18A63", "172" },
  purple =           { "#A88995", "125" },
  red =              { "#C56F6B", "160" },
  yellow =           { "#B89D6B", "178" },
  none =             { "NONE", "NONE"   },
  -- stylua: ignore end
}
