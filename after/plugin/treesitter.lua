
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c",
        "cpp",
        "lua",
        "rust",
        "toml",
        "zig",
        "python",
        "haskell",
        "json",
        "yaml",
        "fish",
        "make",
        "go",
        "fortran"
    },

    highlight = {
        enable = true,
    },
}
