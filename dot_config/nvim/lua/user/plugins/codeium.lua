return {
	"Exafunction/codeium.vim",
	event = { "VimEnter" },
	init = function()
		vim.g.codeium_no_map_tab = true
		vim.g.codeium_filetypes = {
			prompt = false,
			TelescopePrompt = false,
			qf = false,
			help = false,
			nofile = false,
			quickfix = false,
		}
	end,
	config = function()
		vim.cmd([[imap <script><silent><nowait><expr> <Plug>(codeium-accept) codeium#Accept()]])
	end,
}
