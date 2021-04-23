vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
    use "wbthomason/packer.nvim"
    -- use {"arcticicestudio/nord-vim", branch = "develop"}
    use {"maaslalani/nordbuddy", requires = {"tjdevries/colorbuddy.nvim"}}
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-compe"
    use "cohama/lexima.vim"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "tpope/vim-surround"
    use "ojroques/nvim-hardline"
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use "tomtom/tcomment_vim"
    use "editorconfig/editorconfig-vim"
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons"
        }
    }
    use {
        "mg979/vim-visual-multi",
        branch = "master"
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim"
        }
    }
    use "lambdalisue/gina.vim"
    use "glepnir/indent-guides.nvim"
    use {
        "romgrk/barbar.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons"
        }
    }
    use "voldikss/vim-floaterm"
    use {"Vimjas/vim-python-pep8-indent", ft = "python"}
end)
