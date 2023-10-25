local utils = require "astronvim.utils"

local mapping = require("astronvim.utils").empty_map_table()

mapping.n["<leader>lp"] = { name = "Peek" }
mapping.n["<leader>lN"] = { function() vim.lsp.inlay_hint(0) end, desc = "Toggle lsp inlay-hints" }

mapping.t["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" }

if vim.fn.executable "btop" == 1 then
  mapping.n["<leader>tt"] = { function() utils.toggle_term_cmd "btop" end, desc = "ToggleTerm btop" }
end

if vim.g.neovide then
  mapping.n["<C-v>"] = { '"+P', desc = "Paste from clipboard" }
  mapping.v["<C-v>"] = { '"+P', desc = "Paste from clipboard" }
  mapping.c["<C-v>"] = { "<C-R>+", desc = "Paste from clipboard" }
  mapping.i["<C-v>"] = { '<ESC>l"+Pli', desc = "Paste from clipboard" }
end

return mapping
