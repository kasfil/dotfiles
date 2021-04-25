vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
    use "wbthomason/packer.nvim"
    -- use {"arcticicestudio/nord-vim", branch = "develop"}
    use {"novakne/kosmikoa.nvim", branch = "main"}
    use "kyazdani42/blue-moon"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-compe"
    use "glepnir/lspsaga.nvim"
    use "cohama/lexima.vim"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "tpope/vim-surround"
    use {
        "glepnir/galaxyline.nvim", branch = "main",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
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
    use "voldikss/vim-floaterm"
    use {"Vimjas/vim-python-pep8-indent", ft = "python"}
    use {"phaazon/hop.nvim", as = "hop"}
    use {"rrethy/vim-hexokinase", run = "make hexokinase"}
end)
