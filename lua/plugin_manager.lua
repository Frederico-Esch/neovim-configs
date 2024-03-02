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


        use 'nvim-lua/popup.nvim'
        use {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.4',
            requires = {{ 'nvim-lua/plenary.nvim' }, { 'kyazdani42/nvim-web-devicons' }}
        }

        --use {
        --    'vim-airline/vim-airline',
        --    requires = {{'kyazdani42/nvim-web-devicons'}, {'vim-airline/vim-airline-themes'}}
        --}
        use {
          'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        use 'nvim-treesitter/nvim-treesitter'
        use 'ErichDonGubler/lsp_lines.nvim'

        use 'tommcdo/vim-lion'
        use 'tpope/vim-surround'
        use 'easymotion/vim-easymotion'

        use 'voldikss/vim-floaterm'
        use 'tpope/vim-fugitive'
        use 'mbbill/undotree'

        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-vsnip'
        use 'hrsh7th/vim-vsnip'
        use 'hrsh7th/cmp-nvim-lsp-signature-help'
        use 'onsails/lspkind.nvim'

        use 'ziglang/zig.vim'
    end
)
