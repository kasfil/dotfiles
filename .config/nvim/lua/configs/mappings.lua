local map = require("configs.utils").map

vim.g.mapleader = ","

-- quick save
map("n", "<leader>w", "<CMD>w<CR>")

-- quick move window
map("n", "<A-l>", "<C-w>l")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-h>", "<C-w>h")

-- split window
map("n", "<A-\\>", "<CMD>vs<CR>")
map("n", "<C-\\>", "<CMD>sp<CR>")
