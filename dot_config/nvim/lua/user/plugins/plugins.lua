return {
	{
		"mizlan/iswap.nvim",
		cmd = { "ISwap", "ISwapWith", "ISwapNode", "ISwapNodeWith", "ISwapNodeWithLeft", "ISwapNodeWithRight" },
		opts = {},
	},
	{
		"ray-x/lsp_signature.nvim",
		lazy = false,
		event = { "InsertEnter" },
		opts = {
			hint_prefix = "",
			floating_window_off_x = 15,
			floating_window_off_y = -2,
			handler_opt = {
				border = "single",
				winhighlight = "Normal:NormalFloat,FloatBorder:CmpFloatBorder,Pmenu:NormalFloat",
			},
			trigger_on_newline = true,
			padding = " ",
			toggle_key = "<M-x>",
		},
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
}
