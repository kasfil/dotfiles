-- official build with vim script
-- return {
--   "Exafunction/codeium.vim",
--   name = "vimcodeium",
--   event = { "VimEnter" },
--   init = function()
--     vim.g.codeium_manual = 1
--     vim.g.codeium_disable_bindings = true
--     vim.g.codeium_filetypes = {
--       ["neo-tree-popup"] = false,
--       TelescopePrompt = false,
--       qf = false,
--       help = false,
--       quickfix = false,
--     }
--   end,
--   config = function()
--     vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
--     vim.keymap.set(
--       "i",
--       "<c-;>",
--       function() return vim.fn["codeium#CycleCompletions"](1) end,
--       { expr = true, silent = true }
--     )
--     vim.keymap.set(
--       "i",
--       "<c-,>",
--       function() return vim.fn["codeium#CycleCompletions"](-1) end,
--       { expr = true, silent = true }
--     )
--     vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
--   end,
-- }

return {
  "Exafunction/codeium.nvim",
  event = { "VimEnter" },
  requires = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    enable_chat = true,
  },
}
