local cmp       = require'cmp'
local lspconfig = require'lspconfig'
local lspkind   = require'lspkind'
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local os = vim.loop.os_uname().sysname

local servers = {"clangd", "rust_analyzer", "hls", "gopls"} --"zls", "fortls", "ols", 

local snippet_config = {
    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
}

local formatting_config = {
    format = lspkind.cmp_format({ mode = "symbol_text" })
}

local experimental_config = {
    ghost_text = true
}

function on_attach(client, bufnr)

    local remap = vim.keymap.set
    local options = {
        noremap = true,
        silent  = true,
        buffer  = bufnr
    }

    remap("n"  , "gd"        , "<cmd>lua vim.lsp.buf.definition()<CR>"     , options)
    remap("n"  , "gr"        , "<cmd>lua vim.lsp.buf.references()<CR>"     , options)
    remap("n"  , "K"         , "<cmd>lua vim.lsp.buf.hover()<CR>"          , options)
    remap("n"  , "<leader>e" , "<cmd>lua vim.diagnostic.open_float()<CR>"  , options)
    remap("n"  , "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>"         , options)
    remap("n"  , "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>"    , options)
    remap("n"  , "<leader>f" , "<cmd>lua vim.lsp.buf.format()<CR>"         , options)
    --remap("n"  , "<leader>s" , "<cmd>lua vim.lsp.buf.signature_help()<CR>" , options)
    --remap("n", "<leader>pe", "<cmd>lua vim.diagnostic.goto_prev()<CR>"   , options)
    --remap("n", "<leader>ne", "<cmd>lua vim.diagnostic.goto_next()<CR>"   , options)

    local tab_action = function()
        if vim.fn["vsnip#jumpable"](1) == 1 then return "<plug>(vsnip-jump-next)"
        else return "<tab>" end
    end
    remap({ "i", "s" }, "<tab>", tab_action, { expr = true, remap = false })


    local shift_tab_action = function()
        if vim.fn["vsnip#jumpable"](-1) == 1 then return "<plug>(vsnip-jump-prev)"
        else return "<C-h>" end
    end
    remap({ "i", "s" }, "<s-tab>", shift_tab_action, { expr = true, remap = false })
end


--attach options
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


local clangd_config = {
    on_attach = on_attach,
    cmd = { "clangd", "--header-insertion=never" },
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities
}

if (os ~= "Linux") then
    table.insert(clangd_config.cmd, "--query-driver=C:/Users/frede/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-gcc.exe,C:/msys64/mingw64/bin/gcc.exe")
end

for _, lsp in pairs(servers) do

    if lsp == "clangd" then
        lspconfig[lsp].setup(clangd_config)
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
