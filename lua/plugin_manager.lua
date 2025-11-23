vim.cmd.packadd [[packer.nvim]]

require("packer").startup(
    function(use)

        use 'wbthomason/packer.nvim'

        use 'sjl/badwolf'
        use 'wadackel/vim-dogrun'
        use 'dracula/vim'
        use 'eemed/sitruuna.vim'
        use 'jaredgorski/SpaceCamp'
        use 'hachy/eva01.vim'
        use 'EdenEast/nightfox.nvim'
        use 'srcery-colors/srcery-vim'
        use 'maxmx03/fluoromachine.nvim'

        use 'xiyaowong/transparent.nvim'
        use 'lukas-reineke/indent-blankline.nvim'

        use 'nvim-lua/popup.nvim'
        use {
            'nvim-telescope/telescope.nvim',
            requires = {{ 'nvim-lua/plenary.nvim' }, { 'kyazdani42/nvim-web-devicons' }}
        }

        use {
          'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        use 'nvim-treesitter/nvim-treesitter'
        use 'nvim-treesitter/nvim-treesitter-textobjects'
        use 'ErichDonGubler/lsp_lines.nvim'
        use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

        use 'tommcdo/vim-lion'
        use 'tpope/vim-surround'
        use 'easymotion/vim-easymotion'
        use 'lambdalisue/vim-suda'

        use 'voldikss/vim-floaterm'
        use 'tpope/vim-fugitive'
        use 'mbbill/undotree'

        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-vsnip'
        use 'hrsh7th/vim-vsnip'
        use 'hrsh7th/cmp-nvim-lsp-signature-help'
        use 'hrsh7th/nvim-cmp'
        use 'onsails/lspkind.nvim'

        use 'ziglang/zig.vim'
    end
)
