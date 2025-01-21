local get_icon = require("user.utils").get_icon

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        }
      end,
    },
  },
  cmd = "Neotree",
  keys = {
    { "<leader>wet", ":Neotree toggle<CR>", silent = true, desc = "NeoTree toggle" },
    { "<leader>wes", ":Neotree focus<CR>", silent = true, desc = "NeoTree focus" },
  },
  opts = {
    hide_root_node = true,
    log_level = "error",
    popup_border_style = "single",
    default_component_configs = {
      icon = {
        folder_closed = get_icon "folder_closed",
        folder_open = get_icon "folder_open",
        folder_empty = get_icon "folder_empty",
      },
      modified = {
        symbol = get_icon "modified",
      },
      git_status = {
        symbols = {
          added = get_icon "git_added",
          modified = get_icon "git_changed",
          deleted = get_icon "git_removed",
          renamed = get_icon "git_renamed",
          untracked = get_icon "git_untracked",
          ignored = get_icon "git_ignored",
          staged = get_icon "git_staged",
          unstaged = get_icon "git_unstaged",
          conflict = get_icon "git_conflict",
        },
      },
    },
    window = {
      width = 28,
      mappings = {
        ["l"] = "open",
      },
    },
    filesystem = {
      filtered_items = {
        hide_by_name = {
          "node_modules",
        },
        always_show_by_pattern = {
          ".env*",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
        never_show_by_pattern = {
          ".null-ls_*",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      window = {
        mappings = {
          ["q"] = "close_window",
        },
      },
    },
    event_handlers = {
      {
        event = "neo_tree_window_after_open",
        handler = function()
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.signcolumn = "no"
        end,
      },
    },
  },
}
