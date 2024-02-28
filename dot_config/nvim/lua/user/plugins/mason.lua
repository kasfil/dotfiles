return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts) opts.ensure_installed = { "yamlls", "jsonls", "lua_ls" } end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts) opts.ensure_installed = { "stylua" } end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = { "codelldb" }
      opts.handlers = {
        codelldb = function(config)
          -- config.adapters = {
          --   type = "server",
          --   port = "${port}",
          --   host = "127.0.0.1",
          --   executable = {
          --     command = "codelldb",
          --     args = { "--port", "${port}" },
          --   },
          -- }
        end,
      }
    end,
  },
}
