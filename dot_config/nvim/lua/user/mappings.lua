local utils = require "astronvim.utils"
local mapping = utils.empty_map_table()

-- Mapping prefix name
mapping.n["<leader>r"] = { name = "Overseer" }
mapping.n["<leader>x"] = { name = "Misc" }
mapping.n["<leader>lp"] = { name = "Peek" }

mapping.n["<leader>lN"] =
  { function() vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0)) end, desc = "Toggle lsp inlay-hints" }

if vim.fn.executable "btop" == 1 then
  mapping.n["<leader>tt"] = { function() utils.toggle_term_cmd "btop" end, desc = "ToggleTerm btop" }
end

if vim.fn.executable "lazygit" == 1 then
  mapping.n["<leader>tg"] = { function() utils.toggle_term_cmd "lazygit" end, desc = "ToggleTerm lazygit" }
end

if vim.fn.executable "lazysql" == 1 then
  mapping.n["<leader>ts"] = { function() utils.toggle_term_cmd "lazysql" end, desc = "ToggleTerm lazysql" }
end

-- Insert uuid
mapping.n["<leader>xu"] = { 'a<C-r>=trim(system("uuidgen"))<CR><ESC>', desc = "insert uuid" }
mapping.i["<C-x><C-u>"] = { '<C-r>=trim(system("uuidgen"))<CR>', desc = "insert uuid" }

if vim.g.neovide then
  mapping.n["<C-v>"] = { '"+P', desc = "Paste from clipboard" }
  mapping.v["<C-v>"] = { '"+P', desc = "Paste from clipboard" }
  mapping.c["<C-v>"] = { "<C-R>+", desc = "Paste from clipboard" }
  mapping.i["<C-v>"] = { '<ESC>l"+Pli', desc = "Paste from clipboard" }
end

return mapping
