vim.cmd[[packadd packer.nvim]]

return require("packer").startup(function(use)

    --packer
    use 'wbthomason/packer.nvim'


    --themes
    use 'sjl/badwolf'
    use 'tyrannicaltoucan/vim-deep-space'
    use 'wadackel/vim-dogrun'
    use 'dracula/vim'
    use 'sainnhe/sonokai'
    use {
        'kyoz/purify',
        rtp='vim'
    }
    use 'eemed/sitruuna.vim'


    --Telescope
    use 'nvim-lua/popup.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    --airline
    use {
        'vim-airline/vim-airline',
        requires = {{'kyazdani42/nvim-web-devicons'}, {'vim-airline/vim-airline-themes'}}
    }

    --TreeSitter
    use 'nvim-treesitter/nvim-treesitter'


    --utils
    use 'tommcdo/vim-lion'
    use 'tpope/vim-surround'
    use 'voldikss/vim-floaterm'
    use 'tpope/vim-fugitive'

    --lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'onsails/lspkind.nvim'

    --other lsp's
    use 'ziglang/zig.vim'
    use 'Tetralux/odin.vim'


end)
