return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_inlay_hints_background = "dimmed"
      vim.g.gruvbox_material_colors_override = {
        aqua = { "#758876", "87" },
        bg0 = { "#18191a", "16" },
        bg1 = { "#202020", "234" },
        bg2 = { "#202020", "234" },
        bg3 = { "#343231", "235" },
        bg4 = { "#343231", "235" },
        bg5 = { "#464442", "236" },
        bg_current_word = { "#2e2d2c", "238" },
        bg_diff_blue = { "#10292b", "17" },
        bg_diff_green = { "#2c301b", "35" },
        bg_diff_red = { "#321c1c", "52" },
        bg_dim = { "#121415", "16" },
        bg_green = { "#959a66", "100" },
        bg_red = { "#c55c59", "160" },
        bg_statusline1 = { "#252525", "234" },
        bg_statusline2 = { "#2e2d2c", "238" },
        bg_statusline3 = { "#484644", "236" },
        bg_visual_blue = { "#2a3636", "233" },
        bg_visual_green = { "#2f3932", "34" },
        bg_visual_red = { "#3a2b2c", "52" },
        bg_visual_yellow = { "#3c382b", "136" },
        bg_yellow = { "#b58c4f", "178" },
        blue = { "#6c958b", "87" },
        fg0 = { "#c3b493", "136" },
        fg1 = { "#c7b790", "137" },
        green = { "#959a66", "100" },
        grey0 = { "#706b60", "101" },
        grey1 = { "#837a6e", "103" },
        grey2 = { "#948c80", "105" },
        none = { "NONE", "NONE" },
        orange = { "#c07547", "172" },
        purple = { "#b67d87", "125" },
        red = { "#c55c59", "160" },
        yellow = { "#b58c4f", "178" },
      }
    end,
  },
}
