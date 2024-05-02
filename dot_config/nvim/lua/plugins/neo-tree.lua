return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    popup_border_style = "single",
    enable_git_status = true,
    sources = { "filesystem", "git_status" },
    source_selector = {
      winbar = false,
      statusline = false,
      sources = {},
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          "node_modules",
        },
        always_show = {
          ".env",
          "user",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
          "__pycache__",
        },
        never_show_by_pattern = {
          ".null-ls_*",
        },
      },
    },
  },
}
