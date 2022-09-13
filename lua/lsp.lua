local opts = { noremap=true, silent=true }
local servers = {'clangd', 'rust_analyzer', 'pylsp', 'pyright', 'zls', 'hls'}

local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    local map = vim.keymap.set
    local adapt = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

    --lsp remaps
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ne', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>pe', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)


    --build setup for cmake c++
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
            print("You should set the project using :SetupBuild first")
            local lines = {}
            for line in io.lines("CMakeLists.txt") do
                lines[#lines + 1] = line
            end
            local buildname = string.sub(lines[2], 9, #lines[2] -1)
            print("Trying to guess the project name reading CMakeLists, found " .. buildname)
            vim.cmd("!cd 'build' && cmake .. && make")
            vim.cmd("!cd build && ./"..buildname)
        end
    end, {nargs = 0})


    --snippet tab correction
    local tab_action = function()
        if vim.fn["vsnip#jumpable"](1) == 1 then return adapt('<plug>(vsnip-jump-next)')
        else return adapt('<tab>') end
    end
    map({ 'i', 's' }, '<tab>', tab_action, { expr = true, remap = true })


    local shift_tab_action = function()
        if vim.fn["vsnip#jumpable"](-1) == 1 then return adapt('<plug>(vsnip-jump-prev)')
        else return adapt("<C-h>") end
    end
    map({ 'i', 's' }, '<s-tab>', shift_tab_action, { expr = true, remap = true })
end


--servers setup
local cmp = require'cmp'
local lspkind = require'lspkind'

--snippet config
local snippet_config = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end, }

--formatting
local formatting_config = {
    format = lspkind.cmp_format({ mode = "symbol_text" })
}

for _, lsp in pairs(servers) do
    -- Boilerplate for complete

      cmp.setup({
        snippet = snippet_config,
        formatting = formatting_config,
        window = {
          --completion = cmp.config.window.bordered(),
          --documentation = cmp.config.window.bordered(),
        },
        experimental = {
            ghost_text = true
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = false}),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'nvim_lsp_signature_help' },
        },{
          { name = 'buffer' }
        })
      })

    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities
    }
end
