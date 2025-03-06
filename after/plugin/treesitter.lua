require 'nvim-treesitter.install'.compilers = { "clang" }
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
        "go",
        "odin",
        "query",
        "vim",
        "vimdoc",
        "ada",
        "cmake"
    },

    highlight = {
        enable = true,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = false,
            scope_incremental = false,
            node_incremental = "<Leader>n",
            node_decremental = "<Leader>N",
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = false,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["a/"] = { query = "@comment", query_group = "highlights" },
            },
            selection_modes = {
                ['@function.outer'] = 'v',
                ['@function.inner'] = 'v',
                ['@class.outer'] = 'v',
                ['@class.inner'] = 'v',
                ['@comment'] = 'v',
            },
            include_surrounding_whitespace = false,
        },
        swap = { enable = false }, --too grainy, I'll probably prefer to use normal motions instead of this
        move = { enable = false }, --too grainy, easy motions solves this much better
    }
}

--vim.opt.foldlevel = 99
--vim.wo.foldmethod = "expr"
--vim.o.foldexpr = "nvim_treesitter#foldexpr()"
