return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local get_icon = require("astronvim.utils").get_icon
    opts.defaults = {
      prompt_prefix = string.format("%s ", get_icon "Search"),
      selection_caret = string.format("%s ", get_icon "Selected"),
      path_display = { "truncate" },
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = {
          preview_width = 0.6,
          results_width = 0.4,
        },
        width = 0.7,
        height = 0.65,
      },
      file_ignore_patterns = { "node_modules", "%.log", "__pycache__/", ".git/" },
    }
  end,
}
