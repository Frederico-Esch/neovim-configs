syntax on


call plug#begin("/home/frederico/.config/nvim/plugged")

Plug 'sjl/badwolf'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'kyoz/purify', {'rtp':'vim'}
Plug 'wadackel/vim-dogrun'
Plug 'dracula/vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'ziglang/zig.vim'

Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'

Plug 'onsails/lspkind.nvim'

call plug#end()

"colorscheme deep-space

lua <<EOF
	require("init") -- ~/.config/nvim/lua/init.lua
EOF

