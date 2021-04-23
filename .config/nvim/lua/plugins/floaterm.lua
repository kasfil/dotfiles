local g = vim.g
local map = require("configs.utils").map

-- floaterm variable
g.floaterm_keymap_new    = "<F7>"
g.floaterm_keymap_prev   = "<F8>"
g.floaterm_keymap_next   = "<F9>"
g.floaterm_keymap_toggle = "<F12>"

g.floaterm_autoclose = 1

-- Floaterm wrapper
map("n", "<space>lg", "<CMD>FloatermNew --name='lazygit' --height=0.9 --width=0.9 --autoclose=2 lazygit<CR>")
