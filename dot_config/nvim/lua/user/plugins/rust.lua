return {
  {
    "mrcjkb/rustaceanvim",
    dependencies = { "mfussenegger/nvim-dap", "jay-babu/mason-nvim-dap.nvim" },
    ft = { "rust" },
    version = "*",
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = require("astronvim.utils.lsp").on_attach,
        },
        dap = {
          adapter = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            executable = {
              command = "codelldb",
              args = { "--port", "${port}" },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml", "BufRead Cargo.lock" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        src = { cmp = { enabled = true } },
      }
    end,
  },
}
