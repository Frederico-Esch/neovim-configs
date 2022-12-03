local on_attach = function(client, bufnr)

    local map = vim.keymap.set

    --Enables completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    -- See ":help vim.lsp.*" for documentation on any of the below functions
    remapb(bufnr, "n", "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>",       nrnso)
    remapb(bufnr, "n", "gr",        "<cmd>lua vim.lsp.buf.references()<CR>",       nrnso)
    remapb(bufnr, "n", "K",         "<cmd>lua vim.lsp.buf.hover()<CR>",            nrnso)
    remapb(bufnr, "n", "<C-k>",     "<cmd>lua vim.lsp.buf.signature_help()<CR>",   nrnso)
    remapb(bufnr, "n", "<Space>e",  "<cmd>lua vim.diagnostic.open_float()<CR>",    nrnso)
    remapb(bufnr, "n", "<Space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",           nrnso)
    remapb(bufnr, "n", "<Space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",      nrnso)
    remapb(bufnr, "n", "<Space>f",  "<cmd>lua vim.lsp.buf.format()<CR>",       nrnso)
    remapb(bufnr, "n", "<Space>s",  "<cmd>lua vim.lsp.buf.signature_help()<CR>",   nrnso)
    remapb(bufnr, "n", "<Space>pe", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", nrnso)
    remapb(bufnr, "n", "<Space>ne", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", nrnso)


    vim.g.setup_build = nil
    vim.api.nvim_buf_create_user_command(bufnr, "SetupBuild",
    function(opts)
        vim.g.setup_build = opts.args
    end, {nargs = 1})

    vim.api.nvim_buf_create_user_command(bufnr, "Build",
    function(opts)
        if(vim.g.setup_build ~= nil) then
            vim.cmd("!cd 'build' && cmake .. && make")
            vim.cmd("!cd build && ./"..vim.g.setup_build)
        else
            print("It is better to exec :SetupBuild first")
            local lines = {}
            for line in io.lines("CMakeLists.txt") do lines[#lines +1] = line end
            local line = lines[2]
            local projname = string.sub(line, 9, #line -1)
            vim.cmd("!cd 'build' && cmake .. && make")
            vim.cmd("!cd build && ./".. projname)
        end
    end, {nargs = 0})

    --snippet tab correction
    local tab_action = function()
        if vim.fn["vsnip#jumpable"](1) == 1 then return "<plug>(vsnip-jump-next)"
        else return "<tab>" end
    end
    map({ 'i', 's' }, '<tab>', tab_action, { expr = true, remap = false })


    local shift_tab_action = function()
        if vim.fn["vsnip#jumpable"](-1) == 1 then return '<plug>(vsnip-jump-prev)'
        else return "<C-h>" end
    end
    map({ 'i', 's' }, '<s-tab>', shift_tab_action, { expr = true, remap = false })

end

local servers   = {"clangd", "pylsp", "pyright", "rust_analyzer", "zls", "fortls", "ols"}

local cmp       = require'cmp'
local lspconfig = require'lspconfig'
local lspkind   = require'lspkind'

local snippet_config = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end, }
local formatting_config = {
    format = lspkind.cmp_format({ mode = "symbol_text" })
}

for _, lsp in pairs(servers) do

    cmp.setup({
        snippet = snippet_config,
        formatting = formatting_config,
        experimental = {
            ghost_text = true
        },
        window = {
            --completion = cmp.config.window.bordered(),
            --documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(4),
            ["<C-f>"] = cmp.mapping.scroll_docs(-4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm({ select = false}),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "vsnip" },
            { name = "nvim_lsp_signature_help"},
        }, {
            { name = "buffer"}
        })
    })
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    lspconfig[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities
    }

    if lsp == "clangd" then

        lspconfig[lsp].setup {
            on_attach = on_attach,
            cmd = {"clangd", "--log=verbose" ,"--query-driver=/usr/bin/avr-gcc,/usr/bin/avr-g++"}, --
            flags = {
                debounce_text_changes = 150,
            },
            capabilities = capabilities
        }
    end

end

