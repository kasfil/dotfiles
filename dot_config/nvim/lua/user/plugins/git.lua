---@type LazySpec[]
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost" },
    opts = {
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        require("which-key").add {
          { mode = { "n", "v" }, "<leader>h", group = "Git hunk" },
          { mode = "n", "<leader>ht", group = "Toggle" },
        }

        -- navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end, { desc = "Next hunk" })
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, { desc = "Prev hunk" })

        -- actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
        map(
          "v",
          "<leader>hs",
          function() gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          { desc = "Stage hunk" }
        )
        map(
          "v",
          "<leader>hr",
          function() gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          { desc = "Reset hunk" }
        )
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function() gitsigns.blame_line { full = true } end, { desc = "Blame buffer" })
        map("n", "<leader>htb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff buffer" })
        map("n", "<leader>hD", function() gitsigns.diffthis "~" end, { desc = "Diff buffer (Head)" })
        map("n", "<leader>htd", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewFileHistory", "DiffviewOpen" },
    opts = {
      enhanced_diff_view = true,
      hooks = {
        view_opened = function(_) vim.opt_local.equalalways = true end,
      },
    },
  },
}
