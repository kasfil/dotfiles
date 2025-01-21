local bufnr = vim.api.nvim_get_current_buf()

require("which-key").add {
  {
    mode = "n",
    {
      "gra",
      function()
        vim.cmd.RustLsp "codeAction"
      end,
      buffer = bufnr,
    },
    {
      "K",
      function()
        vim.cmd.RustLsp { "hover", "actions" }
      end,
      buffer = bufnr,
    },
  },
}
