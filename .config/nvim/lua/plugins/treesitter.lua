require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = {"python"}
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    }
}
