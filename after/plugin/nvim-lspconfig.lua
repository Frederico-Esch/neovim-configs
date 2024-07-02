--Inclusions
local cmp       = require'cmp'
local lspconfig = require'lspconfig'
local lspkind   = require'lspkind'
local icons     = require'icons'
local ufo       = require'ufo'

--Servers
local servers = {"clangd", "lua_ls", "rust_analyzer", "hls", "gopls", "ols", "zls"} --"fortls", "ccls",

--Setup
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
client_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities) --BETTER FOLDING

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

--Attach function
function on_attach(client, bufnr)
    local options = {
        noremap = true,
        silent  = true,
        buffer  = bufnr
    }

    remap("n"  , "gd"        , "<cmd>lua vim.lsp.buf.definition()<CR>"        , options)
    remap("n"  , "gr"        , "<cmd>lua vim.lsp.buf.references()<CR>"        , options)
    remap("n"  , "<leader>e" , "<cmd>lua vim.diagnostic.open_float()<CR>"     , options)
    remap("n"  , "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>"       , options)
    remap("n"  , "<leader>f" , "<cmd>lua vim.lsp.buf.format()<CR>"            , options)
    remap("n"  , "K"         ,
        function()
            if not ufo.peekFoldedLinesUnderCursor() then
                vim.lsp.buf.hover()
            end
        end,
    options)
    remap("n"  , "<leader>rn",
        function()
             vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
                callback = function()
                    local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
                    vim.api.nvim_feedkeys(key, "c", false)
                    vim.api.nvim_feedkeys("0", "n", false)
                    return true
                end,
            })
            vim.lsp.buf.rename()
        end,
    options)
end

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
        ["<Tab>"]     = cmp.mapping.select_next_item(),
        ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        ["<CR>"]      = cmp.mapping.confirm({ select = false}),
    }),
    sources = cmp.config.sources(
    {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help"},
        { name = "vsnip" },
    }, {
        { name = "buffer"}
    })
})

--Diagnostics
local diag_config = {
    signs = {
        active = true,
            values = {
                { name = "DiagnosticSignError", text = icons.diagnostics.BoldError       },
                { name = "DiagnosticSignWarn" , text = icons.diagnostics.BoldWarning     },
                { name = "DiagnosticSignHint" , text = icons.diagnostics.Hint        },
                { name = "DiagnosticSignInfo" , text = icons.diagnostics.Information },
            },
    },
}
vim.diagnostic.config(diag_config)
for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

--Clang specific config
local clangd_config = {
    on_attach = on_attach,
    --cmd = { "clangd", "--header-insertion=never" },
    cmd = { "clangd" },
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities
}
table.insert(clangd_config.cmd, "--query-driver=**")

--Attaching
for _, lsp in pairs(servers) do

    if lsp == "clangd" then
        lspconfig[lsp].setup(clangd_config)
    elseif lsp == "ccls" then
        lspconfig[lsp].setup(ccls_config)
    else
        lspconfig[lsp].setup {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            },
            capabilities = capabilities
        }
    end
end


ufo.setup({
    enable_get_fold_virt_text = true,
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate, ctx)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
            else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, {chunkText, hlGroup})
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                    suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                end
                break
            end
            curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
    end,
    preview = {
        win_config = {
            border = "single"
        }
    }
}) --BETTER FOLDING
