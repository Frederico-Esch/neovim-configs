syntax on
set tabstop=4 softtabstop=4
set expandtab
set shiftwidth=4
set smartindent
set nu
set relativenumber
set hidden
set nohlsearch
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set clipboard=unnamedplus
set ruler
set laststatus=0
set termguicolors

call plug#begin('~/.config/nvim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'vim-utils/vim-man'
Plug 'wadackel/vim-dogrun'
Plug 'sjl/badwolf'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'kyoz/purify', { 'rtp': 'vim' }

"Plug 'jremmen/vim-ripgrep'
Plug 'lyuts/vim-rtags'
"Plug 'Valloric/YouCompleteMe'
Plug 'frazrepo/vim-rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

colorscheme purify "deep-space
hi Normal guibg=#252834 ctermbg=234
"let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:rainbow_active = 1
let g:netrw_winsize = 20
source $HOME/.config/nvim/plug-config/coc.vim

autocmd FileType java :ALEDisable
autocmd FileType asm :ALEDisable

" airline configs
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = 'luna'
set showtabline=2
let g:airline#extensions#tabline#show_buffers = 1

" keymaps
nnoremap <silent><M-h> :vertical resize +2<CR>
nnoremap <silent><M-l> :vertical resize -2<CR>
nnoremap <silent><M-j> :resize +2<CR>
nnoremap <silent><M-k> :resize -2<CR>

nnoremap <silent><S-m> :Vex<CR>

nmap <silent><S-h> <c-w>h
nmap <silent><S-l> <c-w>l
nmap <silent><S-k> <c-w>k
nmap <silent><S-j> <c-w>j
nnoremap <S-TAB> :bnext<CR>
nnoremap <S-w> :bd<CR>
nnoremap <M-p> :Telescope find_files<CR>
nnoremap <M-b> :Telescope buffers<CR>
