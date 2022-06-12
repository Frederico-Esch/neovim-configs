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

--remaps
remap("n","<M-c>", "<C-v>", {noremap = true}) 
remap("n", "<S-w>", ":bd<CR>", {noremap = true, silent = true})
remap("n", "<S-TAB>", ":bn<CR>", {silent = true})

remap("n", "<S-h>", "<c-w>h", {silent = true})
remap("n", "<S-l>", "<c-w>l", {silent = true})
remap("n", "<S-k>", "<c-w>k", {silent = true})
remap("n", "<S-j>", "<c-w>j", {silent = true})

remap("n", "<M-m>", ":Lex<CR>", {noremap = true, silent = true})
remap("n", "<M-p>", ":Telescope find_files<CR>", {noremap = true})
remap("n", "<M-b>", ":Telescope buffers<CR>", {noremap = true})
remap("n", "<S-t>", ":terminal<CR>", {noremap = true, silent = true})

--remap coc
--
--vim.cmd([[inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"]])
--vim.cmd([[inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"]])
--vim.cmd([[inoremap <nowait><silent><expr> <down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<down>"]])
--vim.cmd([[inoremap <nowait><silent><expr>  <up>  coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" :  "\<up>"]])
--

--airlines
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
--vim.g["airline_theme"] = "badwolf"
vim.g["airline#extensions#tabline#show_buffers"] = 1

--themes
-- vim        | airlines
-- badwolf    | badwolf, base16_colors
-- deep-space | ayu_mirage
-- dogrun     | angr, kolor
-- purify     | angr
vim.cmd("colorscheme badwolf")
vim.g["airline_theme"] = "badwolf"

--Lsp
remap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap=true, silent = false})
remap("n", "<Space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap=true, silent = false})
remap("n", "<Space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap=true, silent = false})
remap("n", "<Space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap=true, silent = false})

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "lua" },
    highlight = {
        enable = true,
    },
}

-- BOILERPLATE
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<Space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = {'clangd', 'rust_analyzer', 'pylsp', 'pyright', 'zls'}

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
    }
    -- Boilerplate for complete
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        }, 
        window = {
          --completion = cmp.config.window.bordered(),
          --documentation = cmp.config.window.bordered(),
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
          { name = 'nvim_lsp_signature_help'},
        }, {
          { name = 'buffer' },
        })
      })

    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    require('lspconfig')[lsp].setup {
        capabilities = capabilities
    }
end
