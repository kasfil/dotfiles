return {
  "s1n7ax/nvim-window-picker",
  event = "VeryLazy",
  name = "window-picker",
  version = "2.*",
  opts = {
    picker_config = {
      statusline_winbar_picker = {
        use_winbar = "smart",
      },
    },
    filter_rules = {
      bo = {
        filetype = { "NvimTree", "neo-tree-popup", "notify", "" },
        buftype = { "terminal", "nofile" },
      },
    },
  },
}
