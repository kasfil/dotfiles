pcall(vim.keymap.del, "n", "]b", { buffer = true })
pcall(vim.keymap.del, "n", "[b", { buffer = true })
vim.keymap.set("n", "q", "<Cmd>q<CR>", { desc = "quit", buffer = 0, nowait = true })
