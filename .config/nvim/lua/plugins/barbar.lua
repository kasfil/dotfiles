local map = require("configs.utils").map

vim.cmd("let g:bufferline = {}")
vim.cmd("let bufferline.animation = v:false")
vim.cmd("let bufferline.closeable = v:false")
vim.cmd("let bufferline.clickable = v:false")
vim.cmd("let bufferline.icon_close_tab = ''")
vim.cmd("let bufferline.maximum_padding = 2")

map("n", "[b", "<CMD>BufferPrevious<CR>")
map("n", "]b", "<CMD>BufferNext<CR>")
map("n", "<A-x>", "<CMD>BufferClose<CR>")
map("n", "<A-s>", "<CMD>BufferPick<CR>")
