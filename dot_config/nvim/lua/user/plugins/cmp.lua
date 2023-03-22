return {
	"hrsh7th/nvim-cmp",
	opts = function(_, opts)
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local function has_words_before()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		local t = function(keys, mode)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode or "n", true)
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
				local kind = require("lspkind").cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
				})(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })
				kind.kind = "" .. strings[1] .. " "

				if strings[2] == "" or strings[2] == nil then
					strings[2] = "Codeium"
				end
				kind.menu = "  [" .. strings[2] .. "]"

				return kind
			end,
		}

		opts.sources = cmp.config.sources({
			{ name = "nvim_lsp", priority = 1000 },
			{ name = "luasnip", priority = 750 },
			{ name = "buffer", priority = 500 },
			{ name = "path", priority = 250 },
		})

		opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["has_key"](vim.api.nvim_buf_get_var(0, "_codeium_completions"), "index") then
				t("<Plug>(codeium-accept)", "i")
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" })

		return opts
	end,
}
