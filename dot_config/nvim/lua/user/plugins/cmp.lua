return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local get_icon = require("astronvim.utils").get_icon
    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    opts.window = {
      documentation = {
        border = "single",
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Pmenu:NormalFloat",
        col_offset = 2,
      },
      completion = {
        border = "single",
        winhighlight = "Normal:NormalFloat,FloatBorder:CmpFloatBorder,Pmenu:NormalFloat",
        col_offset = -1,
        side_padding = 0,
      },
    }

    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format {
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = { Codeium = get_icon "Codeium" .. " codeium" },
        }(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = "" .. strings[1] .. " "

        if strings[2] == "" or strings[2] == nil then strings[2] = "Codeium" end

        kind.menu = "  [" .. strings[2] .. "]"

        return kind
      end,
    }

    opts.experimental = {
      ghost_text = true,
    }

    opts.sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "codeium", priority = 775 },
      { name = "luasnip", priority = 750 },
      { name = "crates", priority = 550 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    }

    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      elseif luasnip.expand_or_locally_jumpable() then
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
}
