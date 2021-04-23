vim.cmd("colorscheme nordbuddy")

-- barbar-nvim
vim.api.nvim_exec([[
    hi! BufferCurrentMod guifg=#ebcb8b guibg=#2e3440
    hi! BufferVisibleMod guifg=#ebcb8b guibg=#4c566a
    hi! BufferInactiveMod guifg=#ebcb8b guibg=#4c566a
]], false)
