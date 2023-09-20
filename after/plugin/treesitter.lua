require 'nvim-treesitter.install'.compilers = { "clang" }
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "rust",
        "toml",
        "zig",
        --"python",
        "haskell",
        "json",
        "yaml",
        "go",
    },

    highlight = {
        enable = true,
    },
}

vim.opt.foldlevel = 99
vim.wo.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
