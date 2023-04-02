return {
	opt = {
		-- set to true or false etc.
		relativenumber = true, -- sets vim.opt.relativenumber
		number = true, -- sets vim.opt.number
		spell = false, -- sets vim.opt.spell
		signcolumn = "yes", -- sets vim.opt.signcolumn to auto
		wrap = false, -- sets vim.opt.wrap
		updatetime = 250,
		list = true,
		listchars = {
			tab = "»·",
			nbsp = "+",
			trail = "·",
			extends = "→",
			precedes = "←",
			eol = "↙",
		},
		fillchars = {
			eob = " ",
			horiz = "━",
			horizup = "┻",
			horizdown = "┳",
			vert = "┃",
			vertleft = "┫",
			vertright = "┣",
			verthoriz = "╋",
			diff = "╱",
			foldopen = "",
			foldclose = "",
			fold = " ",
			msgsep = "-",
		},
		cot = { "menu", "menuone", "noselect", "noinsert" },
	},
	g = {
		mapleader = " ", -- sets vim.g.mapleader
		autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
		cmp_enabled = true, -- enable completion at start
		autopairs_enabled = true, -- enable autopairs at start
		lsp_handlers_enabled = false,
		diagnostics_enabled = true, -- enable diagnostics at start
		status_diagnostics_enabled = true, -- enable diagnostics in statusline
		icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
		ui_notifications_enabled = true, -- disable notifications when toggling UI elements
	},
}
