--Inclusions
local cmp       = require'cmp'
local lspconfig = require'lspconfig'
local lspkind   = require'lspkind'
local icons     = require'icons'

--Servers
local servers = {"clangd", "rust_analyzer", "hls", "gopls", "ols", "zls", "ada_ls"} --"fortls", "ccls","lua_ls",

--Setup
local snippet_config = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end }
local formatting_config = { format = lspkind.cmp_format({ mode = "symbol_text" }) }
local experimental_config = { ghost_text = true }
local os = vim.loop.os_uname().sysname
local remap = vim.keymap.set

--Tab fix
local tab_action = function()
    if vim.fn["vsnip#jumpable"](1) == 1 then return "<plug>(vsnip-jump-next)"
    else return "<tab>" end
end

local shift_tab_action = function()
    if vim.fn["vsnip#jumpable"](-1) == 1 then return "<plug>(vsnip-jump-prev)"
    else return "<C-h>" end
end
remap({ "i", "s" }, "<tab>", tab_action, { expr = true, remap = false })
remap({ "i", "s" }, "<s-tab>", shift_tab_action, { expr = true, remap = false })


--Attach options
cmp.setup({
    snippet = snippet_config,
    formatting = formatting_config,
    experimental = experimental_config,
    window = {
        --completion = cmp.config.window.bordered(),
        --documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"]     = cmp.mapping.scroll_docs(4),
        ["<C-f>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"]     = cmp.mapping.abort(),
        --["<Tab>"]     = cmp.mapping.select_next_item(),
        --["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        ["<CR>"]      = cmp.mapping.confirm({ select = false}),
    }),
    sources = cmp.config.sources(
    {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help"},
        { name = "vsnip" },
        { name = "buffer"}
    })
})

--Diagnostics
local diag_config = {
    signs = {
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
for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

--Attaching
for _, lsp in pairs(servers) do

    config = require("lsp." .. lsp)
    lspconfig[lsp].setup(config)

end
