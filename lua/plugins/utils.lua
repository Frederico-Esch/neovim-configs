return {
    {
        {
            'tpope/vim-fugitive',
            --"NeogitOrg/neogit",
            dependencies = {
                "sindrets/diffview.nvim",
            },
            config = function()
                local remap = vim.keymap.set
                remap("n", "<leader>gg", ":Git<CR>", { silent = true, noremap = true })
            end
        },
        {
            'tommcdo/vim-lion',
            config = function()
                vim.g["lion_squeeze_spaces"] = 1
                vim.g["srcery_italic"] = 1
            end
        },
        {
            'tpope/vim-surround',
            config = function() end
        },
        {
            'easymotion/vim-easymotion',
            config = function() end
        },
        {
            'lambdalisue/vim-suda',
            config = function() end
        },
        {
            'voldikss/vim-floaterm',
            config = function()
                vim.g.floaterm_title = "Terminal($1/$2)"
                vim.api.nvim_set_hl(0, "Floaterm", { bg = "black" })
                vim.g.floaterm_position = 'bottomright'

                if (vim.loop.os_uname().sysname == "Linux") then
                    vim.g.floaterm_shell = 'fish'
                else
                    vim.g.floaterm_shell = 'powershell'
                end

                local remap = vim.keymap.set

                remap("n", "<s-t>", ":FloatermToggle <CR>", { silent = true, noremap = true })
                remap("n", "<leader>tt", ":FloatermNew <CR>", { silent = true, noremap = true })
                remap("n", "<leader>tn", ":FloatermNext<CR>", { silent = true, noremap = true })
                remap({"t", "n", "i"}, "<c-t>", "<C-\\><C-n>:FloatermToggle <CR>", { silent = true, noremap = true })
            end
        },
        {
            'mbbill/undotree',
            config = function() end
        },
        {
            'ziglang/zig.vim',
            config = function()
            end
        },
        {
            "folke/todo-comments.nvim",
            dependencies = { 'folke/snacks.nvim', 'nvim-lua/plenary.nvim' },
            opts = {},
            keys = {
                { "<leader>nt", function() Snacks.picker.todo_comments() end, desc = "Todo" },
            }
        }
    }
}
