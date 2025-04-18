---@module "which-key"
---@type wk.Spec
return {
  mode = "n",
  {
    "<Esc>",
    "<Cmd>nohlsearch<CR>",
    desc = "Remove search highlight",
  },
  {
    "[d",
    "<Cmd>Lspsaga diagnostic_jump_prev<CR>",
    desc = "Previous diagnostic",
  },
  {
    "]d",
    "<Cmd>Lspsaga diagnostic_jump_next<CR>",
    desc = "Next diagnostic",
  },
  {
    "[b",
    ":bprevious<CR>",
    desc = "Previous buffer",
  },
  {
    "]b",
    ":bnext<CR>",
    desc = "Next buffer",
  },

  -- Show info group
  {
    "<leader>sd",
    function() vim.diagnostic.open_float() end,
    desc = "Show diagnostic message",
  },
  {
    "<leader>sqd",
    function() vim.diagnostic.setloclist() end,
    desc = "Quick fix diagnostic",
  },

  -- Buffer group
  { "<leader>b", group = "buffer", icon = " " },
  {
    "<leader>bc",
    function()
      _G.MiniBufremove.delete(0, false) ---@diagnostic disable-line: undefined-field
    end,
    desc = "Delete",
  },
  {
    "<leader>bC",
    function()
      _G.MiniBufremove.delete(0, true) ---@diagnostic disable-line: undefined-field
    end,
    desc = "Force delete!",
  },
  {
    "<leader>bv",
    function()
      -- Get visible buffer in all window
      local visible_buffers = {}
      local wins = vim.api.nvim_list_wins()
      for _, w in ipairs(wins) do
        table.insert(visible_buffers, vim.api.nvim_win_get_buf(w))
      end

      for _, t in ipairs(vim.api.nvim_list_bufs()) do
        local modified = vim.api.nvim_get_option_value("modified", { buf = t })

        if not modified and not vim.tbl_contains(visible_buffers, t) then
          _G.MiniBufremove.wipeout(t) ---@diagnostic disable-line: undefined-field
        end
      end
    end,
    desc = "Vacuum hidden",
  },
  { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close left" },
  { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Close right" },
  { "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
  { "<leader>bq", "<Cmd>BufferLinePickClose<CR>", desc = "Pick close" },

  -- Window group
  { "<leader>w", ":w!<CR>", desc = "Write buffer" },
  { "<leader>q", ":q<CR>", silent = true, desc = "Close" },

  -- Global mapping not started with leader
  -- Navigation by smart-splits.nvim
  -- resizing splits
  {
    "<C-Left>",
    function() require("smart-splits").resize_left() end,
    desc = "Resize window left",
  },
  {
    "<C-Down>",
    function() require("smart-splits").resize_down() end,
    desc = "Resize window down",
  },
  {
    "<C-Up>",
    function() require("smart-splits").resize_up() end,
    desc = "Resize window up",
  },
  {
    "<C-Right>",
    function() require("smart-splits").resize_right() end,
    desc = "Resize window right",
  },
  -- moving between splits
  {
    "<C-h>",
    function() require("smart-splits").move_cursor_left() end,
    desc = "Focus window left",
  },
  {
    "<C-j>",
    function() require("smart-splits").move_cursor_down() end,
    desc = "Focus window down",
  },
  {
    "<C-k>",
    function() require("smart-splits").move_cursor_up() end,
    desc = "Focus window up",
  },
  {
    "<C-l>",
    function() require("smart-splits").move_cursor_right() end,
    desc = "Focus window right",
  },
  -- swapping buffers between windows
  { "<leader>bm", group = "swap", icon = "󰯍 " },
  {
    "<leader>bmh",
    function() require("smart-splits").swap_buf_left() end,
    desc = "Swap window left",
  },
  {
    "<leader>bmj",
    function() require("smart-splits").swap_buf_down() end,
    desc = "Swap window down",
  },
  {
    "<leader>bmk",
    function() require("smart-splits").swap_buf_up() end,
    desc = "Swap window up",
  },
  {
    "<leader>bml",
    function() require("smart-splits").swap_buf_right() end,
    desc = "Swap window right",
  },

  -- Minijump2d
  {
    "<S-CR>",
    function() MiniJump2d.start(MiniJump2d.builtin_opts.query) end,
    desc = "Jump Search",
  },
  {
    "<CR>",
    function() MiniJump2d.start(MiniJump2d.builtin_opts.single_character) end,
    desc = "Jump to char",
  },
}
