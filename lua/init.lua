remap = vim.api.nvim_set_keymap

--settings
require("settings") -- ~/.config/nvim/lua/settings.lua

--remaps
require("base_remaps") -- ~/.config/nvim/lua/base_remaps.lua


--remap coc
--
--vim.cmd([[inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"]])
--vim.cmd([[inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"]])
--vim.cmd([[inoremap <nowait><silent><expr> <down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<down>"]])
--vim.cmd([[inoremap <nowait><silent><expr>  <up>  coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" :  "\<up>"]])
--

--autocmd
require("autocmd") -- ~/.config/nvim/lua/autocmd.lua

--appearence
require("appearence") -- ~/.config/nvim/lua/appearence.lua

--treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "lua", "python", "rust", "toml", "zig", "haskell" },
    highlight = {
        enable = true,
    },
}


--Lsp
require("lsp") -- ~/.config/nvim/lua/lsp.lua
