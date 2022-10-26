remap  = vim.api.nvim_set_keymap
remapb = vim.api.nvim_buf_set_keymap

--settings
require("settings")

--remaps
nro = {noremap = true} --noremap option
so  = {silent = true}  --silent option
nrnso = {noremap = true, silent = true} --noremap and silent opton
require("remaps")

--autocmd
require("autocmd")

--appearance
require("appearance")

--treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "lua", "rust", "toml", "zig", "python", "haskell"},
    highlight = {
        enable = true,
    },
}

--LSP
require("lsp")
