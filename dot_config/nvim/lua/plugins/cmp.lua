return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local get_icon = require("astroui").get_icon
    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    opts = vim.tbl_extend("force", opts, { view = { entries = { follow_cursor = true } } })

    opts.window = {
      documentation = {
        border = "single",
        -- winhighlight = "Normal:CmpDocsFloat,FloatBorder:CmpDocsFloatBorder,Pmenu:CmpDocsFloat",
        -- col_offset = 2,
      },
      completion = {
        border = "none",
        -- winhighlight = "Normal:NormalFloat,FloatBorder:CmpFloatBorder,Pmenu:NormalFloat",
        -- col_offset = -1,
        side_padding = 1,
      },
    }

    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        if entry.source.name == "vim-dadbod-completion" then
          vim_item.menu = "DB"
          vim_item.kind = "DB"
        end

        local abbr_width_max = 20
        local menu_width_max = 15

        local choice = require("lspkind").cmp_format {
          mode = "symbol_text",
          maxwidth = abbr_width_max,
          ellipsis_char = "...",
          symbol_map = {
            DB = get_icon "DB",
            Version = get_icon "Version",
            Codeium = get_icon "Ai",
          },
        }(entry, vim_item)

        choice.abbr = vim.trim(choice.abbr)

        local abbr_width = string.len(choice.abbr)
        if abbr_width < abbr_width_max then
          local padding = string.rep(" ", abbr_width_max - abbr_width)
          vim_item.abbr = choice.abbr .. padding
        end

        local strings = vim.split(choice.kind, "%s", { trimempty = true })
        choice.kind = strings[1] .. " "

        local cmp_ctx = "[" .. strings[2] .. "]"
        if cmp_ctx ~= nil and cmp_ctx ~= "" then
          choice.menu = cmp_ctx
        else
          choice.menu = ""
        end

        local menu_width = string.len(choice.menu)
        if menu_width > menu_width_max then
          choice.menu = vim.fn.strcharpart(choice.menu, 0, menu_width_max - 1)
          choice.menu = choice.menu .. "..."
        else
          local padding = string.rep(" ", menu_width_max - menu_width)
          choice.menu = padding .. choice.menu
        end

        return choice
      end,
    }

    opts.experimental = {
      ghost_text = true,
    }

    opts.sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "crates", priority = 550 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "vim-dadbod-completion", priority = 200 },
      { name = "codeium", priority = 50 },
    }

    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      elseif luasnip.in_snippet() and luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" })

    opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })

    return opts
  end,
  config = function(_, opts)
    local cmp = require "cmp"
    cmp.setup(opts)
  end,
}
