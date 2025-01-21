local wk = require "which-key"
local bufnr = vim.api.nvim_get_current_buf()

wk.add({
  ["<leader>l"] = {
    c = {
      name = "flyCheck",
      r = {
        function() vim.cmd.RustLsp { "flyCheck", "run" } end,
        "Flycheck run",
        noremap = true,
      },
      x = {
        function() vim.cmd.RustLsp { "flyCheck", "clear" } end,
        "Flycheck clear",
        noremap = true,
      },
      c = {
        function() vim.cmd.RustLsp { "flyCheck", "cancel" } end,
        "Flycheck cancel",
        noremap = true,
      },
    },
    a = {
      function() vim.cmd.RustLsp "codeAction" end,
      "LSP code action",
      noremap = true,
    },
  },
}, { silent = true, buffer = bufnr })
