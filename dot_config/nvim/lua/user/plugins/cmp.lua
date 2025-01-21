return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
  },
  config = function()
    -- See `:help cmp`
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local cvt = require "codeium.virtual_text"
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      preselect = cmp.PreselectMode.None,
      completion = { completeopt = "menu,menuone,noinsert,noselect" },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind =
            require("lspkind").cmp_format { mode = "symbol_text", maxwidth = 50, preset = "codicons" }(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = "" .. (strings[1] or "") .. " "
          kind.menu = "    [" .. (strings[2] or "") .. "]"

          return kind
        end,
      },

      -- NOTE: when using codeium.vim status could be found from b:_codeium_status
      -- 0 = idle
      -- 1 = waiting
      -- 2 = completions
      -- also check b:_codeium_completions "items" length for available completions item

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif cvt.status().total and cvt.status().total > 0 then
            cvt.cycle_completions(1)
          else
            fallback()
          end
        end),

        -- Select the [p]revious item
        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif cvt.status().total and cvt.status().total > 0 then
            cvt.cycle_completions(-1)
          else
            fallback()
          end
        end),

        -- Scroll the documentation window [b]ack / [f]orward
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ["<C-y>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { select = true }
          else
            fallback()
          end
        end),

        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ["<C-Space>"] = cmp.mapping(function()
          if not cmp.visible() then
            cmp.complete()
          elseif not cmp.visible_docs() then
            cmp.open_docs()
          else
            cmp.close_docs()
          end
        end),

        -- add esc sequence support for codeium
        ["<C-e>"] = cmp.mapping(function(fallback)
          -- vim.notify("Codeium status: " .. vim.b._codeium_status)
          if cmp.visible() then
            cmp.close()
            cvt.cycle_or_complete()
          else
            cvt.clear()
            fallback()
          end
        end),

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      },
    }
  end,
}
