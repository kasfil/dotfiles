return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function() return vim.fn.executable "make" == 1 end,
    },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",

    -- Useful for getting pretty icons, but requires a Nerd Font.
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local get_icon = require("user.utils").get_icon
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local transform_mod = require("telescope.actions.mt").transform_mod

    local function multiopen(prompt_bufnr, method)
      local edit_file_cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        tab = "tabedit",
        default = "edit",
      }
      local edit_buf_cmd_map = {
        vertical = "vert sbuffer",
        horizontal = "sbuffer",
        tab = "tab sbuffer",
        default = "buffer",
      }
      local picker = action_state.get_current_picker(prompt_bufnr)
      local multi_selection = picker:get_multi_selection()

      if #multi_selection > 1 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
          local filename, row, col

          if entry.path or entry.filename then
            filename = entry.path or entry.filename

            row = entry.row or entry.lnum
            col = vim.F.if_nil(entry.col, 1)
          elseif not entry.bufnr then
            local value = entry.value
            if not value then return end

            if type(value) == "table" then value = entry.display end

            local sections = vim.split(value, ":")

            filename = sections[1]
            row = tonumber(sections[2])
            col = tonumber(sections[3])
          end

          local entry_bufnr = entry.bufnr

          if entry_bufnr then
            if not vim.api.nvim_get_option_value("buflisted", entry_bufnr) then
              vim.api.nvim_set_option_value("buflisted", true, { buf = entry_bufnr })
            end
            local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
            ---@diagnostic disable-next-line: param-type-mismatch
            pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
          else
            local command = i == 1 and "edit" or edit_file_cmd_map[method]
            if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
              filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.uv.cwd())
              ---@diagnostic disable-next-line: param-type-mismatch
              pcall(vim.cmd, string.format("%s %s", command, filename))
            end
          end

          if row and col then pcall(vim.api.nvim_win_set_cursor, 0, { row, col }) end
        end
      else
        actions["select_" .. method](prompt_bufnr)
      end
    end

    local custom_actions = transform_mod {
      multi_selection_open_vertical = function(prompt_bufnr) multiopen(prompt_bufnr, "vertical") end,
      multi_selection_open_horizontal = function(prompt_bufnr) multiopen(prompt_bufnr, "horizontal") end,
      multi_selection_open_tab = function(prompt_bufnr) multiopen(prompt_bufnr, "tab") end,
      multi_selection_open = function(prompt_bufnr) multiopen(prompt_bufnr, "default") end,
    }

    local function stopinsert(callback)
      return function(prompt_bufnr)
        vim.cmd.stopinsert()
        vim.schedule(function() callback(prompt_bufnr) end)
      end
    end

    require("telescope").setup {
      defaults = {
        layout_config = {
          horizontal = {
            height = 0.7,
            width = 0.8,
            preview_width = 0.6,
          },
        },
        multi_icon = "",
        mappings = {
          i = {
            ["<C-v>"] = stopinsert(custom_actions.multi_selection_open_vertical),
            ["<C-s>"] = stopinsert(custom_actions.multi_selection_open_horizontal),
            ["<C-t>"] = stopinsert(custom_actions.multi_selection_open_tab),
            ["<CR>"] = stopinsert(custom_actions.multi_selection_open),
          },
          n = {
            ["<C-v>"] = custom_actions.multi_selection_open_vertical,
            ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
            ["<C-t>"] = custom_actions.multi_selection_open_tab,
            ["<CR>"] = custom_actions.multi_selection_open,
          },
        },
        prompt_prefix = get_icon "telescope_prompt_prefix",
        selection_caret = get_icon "telescope_select_caret",
      },
      pickers = {
        lsp_definitions = {
          theme = "dropdown",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "persisted")
    pcall(require("telescope").load_extension, "live_grep_args")

    -- See `:help telescope.builtin`
    local builtin = require "telescope.builtin"
    require("which-key").add({
      { "<leader>fh", builtin.help_tags, desc = "Find Help" },
      { "<leader>fk", builtin.keymaps, desc = "Find Keymap" },
      { "<leader>ff", builtin.find_files, desc = "Find Files" },
      { "<leader>fs", builtin.builtin, desc = "Find Builtin Telescope" },
      { "<leader>fw", builtin.live_grep, desc = "Find Word" },
      { "<leader>fg", require("telescope").extensions.live_grep_args.live_grep_args, desc = "Advanced find word" },
      { "<leader>fd", builtin.diagnostics, desc = "Find Diagnostic" },
      { "<leader>fr", builtin.resume, desc = "Resume Last Find" },
      { "<leader>f.", builtin.oldfiles, desc = "Find Recent Files" },
      { "<leader>fb", builtin.buffers, desc = "Find Existing Buffers" },

      -- Slightly advanced example of overriding default behavior and theme
      {
        "<leader>fz",
        function()
          -- You can pass additional configuration to Telescope to change the theme, layout, etc.
          builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
            previewer = false,
          })
        end,
        desc = "Find Word in Current Buffer",
      },

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      {
        "<leader>f/",
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          }
        end,
        desc = "Find Word in All Opened Files",
      },

      { "<leader>f", group = "find" },
    }, { mode = "n" })
  end,
}
