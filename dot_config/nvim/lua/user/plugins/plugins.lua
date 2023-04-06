return {
	{
		"mizlan/iswap.nvim",
		cmd = { "ISwap", "ISwapWith", "ISwapNode", "ISwapNodeWith", "ISwapNodeWithLeft", "ISwapNodeWithRight" },
		opts = {},
	},
	{ "max397574/better-escape.nvim", enabled = false },
	{
		"tenxsoydev/karen-yank.nvim",
		event = { "VimEnter" },
		config = true,
	},
	{
		"mrjones2014/smart-splits.nvim",
		opts = function(_, opts)
			opts.multiplexer_integration = "wezterm"
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		lazy = false,
		event = { "InsertEnter" },
		opts = function()
			local function offsety()
				local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
				local pumheight = vim.o.pumheight -- my default 10
				local winline = vim.fn.winline() -- line number in the window
				local winheight = vim.fn.winheight(0)

				-- window top
				if linenr < pumheight then
					return pumheight
				end

				-- window bottom
				if winheight - winline < pumheight then
					return -pumheight
				end

				return 0
			end

			return {
				hint_prefix = "",
				floating_window_off_x = 0,
				floating_window_off_y = offsety,
				handler_opt = {
					border = "single",
					winhighlight = "Normal:NormalFloat,FloatBorder:CmpFloatBorder,Pmenu:NormalFloat",
				},
				trigger_on_newline = true,
				padding = " ",
				toggle_key = "<M-x>",
			}
		end,
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"folke/trouble.nvim",
				opts = {
					use_diagnostic_signs = true,
				},
			},
		},
		event = "BufReadPre",
		opts = {
			keywords = {
				TEST = { alt = { "TESTING", "PASSED" } },
			},
		},
	},
	{
		"kylechui/nvim-surround",
		event = { "InsertEnter" },
		version = "*",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"ggandor/leap.nvim",
		lazy = false,
		event = "BufReadPost",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = function(_, opts)
			opts.char = "│"
			opts.context_char = "│"
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = { "VimEnter" },
		keys = {
			{
				"<leader>u0",
				function()
					require("notify").dismiss()
				end,
				desc = "Dissmiss notification",
			},
		},
		opts = {
			background_colour = "NotifyBackground",
			render = "compact",
			stages = "slide",
			timeout = 2000,
		},
	},
}
