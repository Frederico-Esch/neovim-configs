local remap = vim.api.nvim_set_keymap

--settings
vim.o.tabstop         = 4
vim.o.softtabstop     = 4
vim.o.expandtab       = true
vim.o.shiftwidth      = 4
vim.o.smartindent     = true
vim.o.rnu             = true
vim.o.nu              = true
vim.o.hlsearch        = false
vim.g.errorbells      = false
vim.o.wrap            = false
vim.o.swapfile        = false
vim.o.backup          = false
vim.o.undodir         = "/home/frederico/.config/nvim/undodir"
vim.o.undofile        = true
vim.o.incsearch       = true
vim.o.scrolloff       = 8
vim.g.signcolumn      = true
vim.g.clipboard       = "unnamedplus"
vim.g.ruler           = true
vim.g.laststatus      = 0
vim.opt.termguicolors = true

vim.o.list            = true
vim.o.listchars       = "tab:➤ ,lead:·,trail:❤"

--remaps
remap("n","<M-c>", "<C-v>", {noremap = true})
remap("n", "<S-w>", ":bd<CR>", {noremap = true, silent = true})
remap("n", "<S-TAB>", ":bn<CR>", {silent = true})

remap("n", "<C-h>", "<c-w>h", {silent = true})
remap("n", "<C-l>", "<c-w>l", {silent = true})
remap("n", "<C-k>", "<c-w>k", {silent = true})
remap("n", "<C-j>", "<c-w>j", {silent = true})

remap("n", "<M-m>", ":Lex<CR>", {noremap = true, silent = true})
remap("n", "<M-p>", ":Telescope find_files<CR>", {noremap = true})
remap("n", "<M-b>", ":Telescope buffers<CR>", {noremap = true})
remap("n", "<S-t>", ":FloatermToggle --cwd=pwd<CR>", {noremap = true, silent = true})

--remap coc
--
--vim.cmd([[inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"]])
--vim.cmd([[inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"]])
--vim.cmd([[inoremap <nowait><silent><expr> <down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<down>"]])
--vim.cmd([[inoremap <nowait><silent><expr>  <up>  coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" :  "\<up>"]])
--

vim.api.nvim_create_autocmd("Filetype", {
    pattern  = {"markdown"},
    callback = function()
        remap("n", "<Space>co", ":FloatermNew --silent pandoc -s -M pagetitle=\"%<\" --katex=\"./katex/\" -o %<.html %", {})
        vim.wo.wrap = true
        vim.wo.linebreak = true
    end
})

--vim-lion
vim.g["lion_squeeze_spaces"] = 1

--Floaterm
vim.g["floaterm_title"] = "Terminal($1/$2)"

--airlines
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g["airline#extensions#tabline#show_buffers"] = 1

--themes
-- vim        | airlines
-- badwolf    | badwolf, base16_colors, dark
-- deep-space | ayu_mirage
-- dogrun     | angr, kolor
-- purify     | angr
vim.cmd("colorscheme dogrun")
vim.g["airline_theme"] = "kolor"

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "lua", "python", "rust", "toml", "zig", "haskell" },
    highlight = {
        enable = true,
    },
}

-- BOILERPLATE
local opts = { noremap=true, silent=true }

--Lsp
local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ne', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>pe', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = {'clangd', 'rust_analyzer', 'pylsp', 'pyright', 'zls', 'hls'}

for _, lsp in pairs(servers) do
    -- Boilerplate for complete
      local cmp = require'cmp'
      local lspkind = require'lspkind'

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text"
            })
        },
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
