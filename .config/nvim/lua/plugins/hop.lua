local map = require("configs.utils").map
require('hop').setup {keys = "etovxqpdygfblzhckisuran", term_seq_bias = 0.5}

map("n", "mw", "<CMD>lua require('hop').hint_words()<CR>")
map("n", "ms", "<CMD>lua require('hop').hint_char2()<CR>")
