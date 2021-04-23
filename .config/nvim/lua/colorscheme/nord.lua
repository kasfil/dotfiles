vim.cmd("colorscheme nordbuddy")

vim.g.nord_bold = 1
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1

-- vim.api.nvim_exec([[
--     hi LspDiagnosticsVirtualTextError guifg=#bf616a
--     hi LspDiagnosticsVirtualTextWarning guifg=#ebcb8b
--     hi LspDiagnosticsVirtualTextInformation guifg=#88c0d0
--     hi LspDiagnosticsVirtualTextHint guifg=#88c0d0
--
--     hi LspDiagnosticsSignError guifg=#bf616a
--     hi LspDiagnosticsSignWarning guifg=#ebcb8b
--     hi LspDiagnosticsSignInformation guifg=#88c0d0
--     hi LspDiagnosticsSignHint guifg=#88c0d0
-- ]], false)

-- barbar-nvim
vim.api.nvim_exec([[
    hi! BufferCurrentMod guifg=#ebcb8b guibg=#2e3440
    hi! BufferVisibleMod guifg=#ebcb8b guibg=#4c566a
    hi! BufferInactiveMod guifg=#ebcb8b guibg=#4c566a
]], false)
