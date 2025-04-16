local get_icon = require("user.utils").get_icon

return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/schemastore.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      { "Bilal2453/luvit-meta", lazy = true },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- Or relative, which means they will be resolved from the plugin dir.
            "lazy.nvim",
            "nvim-dap-ui",
            -- It can also be a table with trigger words / mods
            -- Only load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
            "echasnovski/mini.nvim",
          },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("grd", "<Cmd>Lspsaga goto_definition<CR>", "Goto Definition")
          map("grr", "<Cmd>Lspsaga finder ref<CR>", "Goto References")
          map("gri", "<Cmd>Lspsaga finder imp<CR>", "Goto Implementation")
          map("grt", "<Cmd>Lspsaga goto_type_definition<CR>", "Type Definition")
          map("grO", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
          map("grW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
          map("grD", vim.lsp.buf.declaration, "Goto Declaration")
          map("grn", "<Cmd>Lspsaga rename<CR>", "Rename")
          map("gra", "<Cmd>Lspsaga code_action<CR>", "Code Action")
          map("grl", vim.lsp.codelens.run, "Run Codelens")
          map("K", function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then vim.cmd["Lspsaga"] "hover_doc" end
          end, "Hover documentation")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
              end,
            })
          end

          -- attach nvim-navic if support documentSymbolProvider
          if client and client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, event.buf)
          end

          -- if client support for lsp signature help then create toggle key
          -- this likely unecessary, but default signature help is taking all window width
          -- then we need to pass the config to make it usable
          if client and client.server_capabilities.signatureHelpProvider then
            vim.keymap.set(
              { "i", "n" },
              "<C-k>",
              function()
                vim.lsp.buf.signature_help {
                  silent = true,
                  max_width = 70,
                  max_height = 12,
                  focusable = false,
                  border = "single",
                  title = "LSP Signature",
                  title_pos = "center",
                }
              end,
              { silent = true, buffer = event.buf }
            )
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            -- enable the inlay hint if it supported
            vim.lsp.inlay_hint.enable(true)
          end

          vim.diagnostic.config {
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = get_icon "error_sign",
                [vim.diagnostic.severity.WARN] = get_icon "warning_sign",
                [vim.diagnostic.severity.INFO] = get_icon "info_sign",
                [vim.diagnostic.severity.HINT] = get_icon "hint_sign",
              },
            },
            float = {
              source = true,
              border = "single",
            },
            virtual_text = false,
          }

          -- remove unused builtin map if exists
          pcall(vim.keymap.del, "n", "gO", {})
          pcall(vim.keymap.del, { "n", "i" }, "<C-s>", {})
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        -- Python
        basedpyright = {},
        ruff = {
          init_options = {
            settings = {
              lineLength = 100,
              organizeImports = true,
              logLevel = "error",
            },
          },
        },

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" }, globals = { "Snacks" } },
              hint = {
                enable = true,
                arrayIndex = "Disable",
              },
            },
          },
        },

        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
      }

      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { "stylua", "debugpy" })

      -- install additional tool based on language tool existance
      -- Go-lang
      if vim.fn.executable "go" == 1 then vim.list_extend(ensure_installed, { "revive", "delve" }) end
      -- Rust
      if vim.fn.executable "cargo" == 1 then vim.list_extend(ensure_installed, { "codelldb" }) end
      -- PHP
      if vim.fn.executable "php" == 1 then
        vim.list_extend(ensure_installed, { "phpactor", "intelephense", "phpcs", "php-cs-fixer" })
      end

      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      require("mason-lspconfig").setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
          ["rust_analyzer"] = function() end,
        },
      }
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = { "LspAttach" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      symbol_in_winbar = { enable = false },
      outline = {
        detail = false,
        win_width = 45,
      },
      code_action = {
        show_server_name = true,
        keys = {
          quit = { "q", "<Esc>" },
          exec = { "<CR>" },
        },
      },
      hover = {
        max_width = 0.5,
        max_height = 0.3,
      },
      lightbulb = {
        sign = false,
      },
      ui = {
        border = "single",
        expand = "",
        collapse = "",
        code_action = " 󰌵",
        actionfix = " ",
        imp_sign = "󰳛 ",
        lines = { "└", "├", "│", "─", "┌" },
      },
    },
  },
  { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        go = { "revive" },
        python = { "ruff" },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
      layout = {
        max_width = { 50, 0.3 },
        min_width = 20,
        win_opts = {
          winhl = "Normal:SideWin",
          statuscolumn = " ",
        },
      },
      filter_kind = false,
      show_guides = true,
      icons = {
        Array = get_icon "array",
        Boolean = get_icon "boolean",
        Class = get_icon "class",
        Constant = get_icon "constant",
        Constructor = get_icon "constructor",
        Enum = get_icon "enum",
        EnumMember = get_icon "enummember",
        Event = get_icon "event",
        Field = get_icon "field",
        File = get_icon "file",
        Function = get_icon "function",
        Interface = get_icon "interface",
        Key = get_icon "key",
        Method = get_icon "method",
        Module = get_icon "module",
        Namespace = get_icon "namespace",
        Null = get_icon "null",
        Number = get_icon "number",
        Object = get_icon "object",
        Operator = get_icon "operator",
        Package = get_icon "package",
        Property = get_icon "property",
        String = get_icon "string",
        Struct = get_icon "struct",
        TypeParameter = get_icon "typeparameter",
        Variable = get_icon "variable",
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      icons = {
        Array = get_icon "array",
        Boolean = get_icon "boolean",
        Class = get_icon "class",
        Constant = get_icon "constant",
        Constructor = get_icon "constructor",
        Enum = get_icon "enum",
        EnumMember = get_icon "enummember",
        Event = get_icon "event",
        Field = get_icon "field",
        File = get_icon "file",
        Function = get_icon "function",
        Interface = get_icon "interface",
        Key = get_icon "key",
        Method = get_icon "method",
        Module = get_icon "module",
        Namespace = get_icon "namespace",
        Null = get_icon "null",
        Number = get_icon "number",
        Object = get_icon "object",
        Operator = get_icon "operator",
        Package = get_icon "package",
        Property = get_icon "property",
        String = get_icon "string",
        Struct = get_icon "struct",
        TypeParameter = get_icon "typeparameter",
        Variable = get_icon "variable",
      },

      highlight = true,
      separator = get_icon "telescope_select_caret",
      depth_limit = 5,
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>bf",
        function() require("conform").format { lsp_fallback = true } end,
        mode = "n",
        desc = "format",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format", "black", "isort" },
        go = { "goimports" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },
}
