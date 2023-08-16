local mapping = {
  n = {
    ["<leader>lp"] = { name = "Peek" },
  },
  t = {
    ["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
  },
  v = {},
  c = {},
  i = {},
}

if vim.g.neovide then
  mapping.n["<C-v>"] = { '"+P', desc = "Paste from clipboard" }
  mapping.v["<C-v>"] = { '"+P', desc = "Paste from clipboard" }
  mapping.c["<C-v>"] = { "<C-R>+", desc = "Paste from clipboard" }
  mapping.i["<C-v>"] = { '<ESC>l"+Pli', desc = "Paste from clipboard" }
end

return mapping
