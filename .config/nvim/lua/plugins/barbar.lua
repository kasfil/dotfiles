local g = vim.g
local map = require("configs.utils").map

g.bufferline = {
    animation = false,
    auto_hide = false,
    tabpages = true,
    icons = true,
    clickable = false,
    no_name_tittle = "Unnamed"
}

map("n", "<A-,>", "<CMD>BufferPrevious<CR>")
map("n", "<A-.>", "<CMD>BufferNext<CR>")
map("n", "<A-x>", "<CMD>BufferClose<CR>")
