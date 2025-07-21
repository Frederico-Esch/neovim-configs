vim.cmd.packadd [[packer.nvim]]


require("packer").startup(function(use)

    use 'wbthomason/packer.nvim'

    use 'eemed/sitruuna.vim'
    use 'hachy/eva01.vim'
    use 'Mofiqul/dracula.nvim'

    use 'xiyaowong/transparent.nvim'

    use 'tpope/vim-surround'
    use 'easymotion/vim-easymotion'


    use 'voldikss/vim-floaterm'
    use 'tpope/vim-fugitive'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{ 'nvim-lua/plenary.nvim' }, { 'kyazdani42/nvim-web-devicons' }, { 'nvim-lua/popup.nvim' } }
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'lukas-reineke/indent-blankline.nvim'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'lambdalisue/vim-suda'
end)
