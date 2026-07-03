local os    = vim.loop.os_uname().sysname
local remap = vim.keymap.set
local icons = require'icons'
vim.g.zig_fmt_autosave = false

return {
    {
        'seblyng/roslyn.nvim',
        opts = {
        }
    },
    {
        'ziglang/zig.vim',
        config = function()
            vim.g.zig_fmt_autosave = false
        end
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'hrsh7th/vim-vsnip', 'saghen/blink.lib' },
        build = function() require('blink.cmp').build():pwait() end,
        opts = {
            cmdline = { enabled = false },
            completion = {
                keyword = { range = 'full' },
                accept = { auto_brackets = { enabled = false }, },
                list = { selection = { preselect = false, auto_insert = true } },
                menu = {
                    auto_show = true,
                    border = 'rounded',
                    winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
                    draw = {
                        treesitter = { 'lsp' },
                        columns = {
                            { "kind_icon", "label" },
                            { "kind", "label_description" },
                        },
                    }
                },
                documentation = {
                    auto_show = true, auto_show_delay_ms = 500,
                    window = { border = 'rounded', winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None", },
                },
                ghost_text = { enabled = true },
            },
            sources = {
                default = { 'lsp', 'snippets', 'buffer', 'path' },
            },
            snippets = { preset = 'vsnip' }, -- 'default'
            signature = {
                enabled = true,
                window = { border = 'rounded', winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None", }, --disable to be able to see what this is
            },

            fuzzy = { implementation = 'rust' },

            keymap = {
                preset = 'none',
                ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' }, --Doesn't work in the microslop terminal :P
                ['<C-d>'] = { 'show_documentation', 'hide_documentation', 'fallback' }, --fallback for my windows terminal
                ['<C-n>'] = { 'show', 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-b>'] = { 'scroll_documentation_down' },
                ['<C-e>'] = { 'cancel', 'fallback' },
                ['<C-s>'] = { 'show_signature', 'fallback' },
                ['<Tab>'] = { 'accept', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
                --Maybe I have to add 'K' to show docs | Idk if it's needed, but it's working
            }
        }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            --'hrsh7th/cmp-nvim-lsp',
            --'onsails/lspkind.nvim',
            --'hrsh7th/cmp-buffer',
            --'hrsh7th/cmp-vsnip',
            --'hrsh7th/cmp-nvim-lsp-signature-help',
            --'hrsh7th/nvim-cmp',--TODO: try blink https://cmp.saghen.dev/configuration/general.html
            'saghen/blink.cmp'
        },
        config = function()
            local lspconfig = vim.lsp

            --Diagnostics
            local diag_config = {
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN]  = icons.diagnostics.Warning,
                        [vim.diagnostic.severity.HINT]  = icons.diagnostics.Hint,
                        [vim.diagnostic.severity.INFO]  = icons.diagnostics.Information
                    },
                    texthl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo"
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo"
                    },
                    active = true,
                    values = {
                        { name = "DiagnosticSignError", text = icons.diagnostics.Error       },
                        { name = "DiagnosticSignWarn" , text = icons.diagnostics.Warning     },
                        { name = "DiagnosticSignHint" , text = icons.diagnostics.Hint        },
                        { name = "DiagnosticSignInfo" , text = icons.diagnostics.Information },
                    },
                },
            }
            vim.diagnostic.config(diag_config)
            --for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
            --    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
            --end

            --Servers
            local servers = {"clangd", "rust_analyzer", "hls", "gopls", "ols", "zls", "ada_ls"} --"fortls", "ccls","lua_ls",
            --Attaching
            for _, lsp in pairs(servers) do

                config = require("lsp." .. lsp)
                lspconfig.enable(lsp)
                lspconfig.config(lsp, config)

            end
        end
    }
}
