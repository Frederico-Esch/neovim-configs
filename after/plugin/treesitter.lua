require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "rust",
        "toml",
        "zig",
        "python",
        "haskell",
        "json",
        "yaml",
        "go",
    },

    highlight = {
        enable = true,
    },
}
