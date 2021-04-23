local g = vim.g
local map = require("configs.utils").map

g.nvim_tree_ignore = {".git", "__pycache__", "node_modules"}
g.nvim_tree_git_hl = 1
g.nvim_tree_lsp_diagnostics = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_auto_close = 1
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1

map("n", "<A-n>", "<CMD>NvimTreeToggle<CR>")
