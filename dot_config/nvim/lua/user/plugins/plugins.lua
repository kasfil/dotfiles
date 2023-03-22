return {
	{
		"mizlan/iswap.nvim",
		cmd = { "ISwap", "ISwapWith", "ISwapNode", "ISwapNodeWith", "ISwapNodeWithLeft", "ISwapNodeWithRight" },
		opts = {},
	},
	{
		-- temporary disable because newlines bug in python pytest library
		"ray-x/lsp_signature.nvim",
		lazy = false,
		enabled = false,
		event = { "InsertEnter" },
		opts = {
			hint_prefix = "",
			handler_opt = {
				border = "single",
				winhighlight = "Normal:NormalFloat,FloatBorder:CmpFloatBorder,Pmenu:NormalFloat",
			},
			trigger_on_newline = true,
			padding = " ",
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
