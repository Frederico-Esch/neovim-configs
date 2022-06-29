local remap  = vim.api.nvim_set_keymap
local remapb = vim.api.nvim_buf_set_keymap

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
local nro = {noremap = true} --noremap option
local so  = {silent = true}  --silent option
local nrnso = {noremap = true, silent = true} --noremap and silent opton

remap("n", "<M-c>", "<C-v>", nro)
remap("n", "<S-w>", ":bd<CR>", nrnso)
remap("n", "<S-TAB>", ":bn<CR>", so)

remap("n", "<C-h>", "<c-w>h", so)
remap("n", "<C-j>", "<c-w>j", so)
remap("n", "<C-l>", "<c-w>l", so)
remap("n", "<C-k>", "<c-w>k", so)

remap("n", "<M-m>", ":Lex<CR>", nrnso)
remap("n", "<M-p>", ":Telescope find_files<CR>", nro)
remap("n", "<M-b>", ":Telescope buffers<CR>", nro)
remap("n", "<S-t>", ":FloatermToggle --cwd=pwd<CR>", nrnso)

--markdown
--remap("n", "<Space>co", ":FloatermNew --silent --disposable pandoc -s -M pagetitle=\"roteiro\" --katex=\"D:\\\\Matérias\\\\Período 3\\\\fisica\\\\katex\\\\\" -o roteiro.html roteiro.md", {})

vim.api.nvim_create_autocmd("Filetype", {
    pattern  = {"markdown"},
    callback = function()
        remap("n", "<Space>co", ":FloatermNew --silent pandoc -s -M pagetitle=\"%<\" --katex=\"./katex/\" -o %<.html %", {}) -- %:p:s?[^/]*\\.[^/]*??
        vim.wo.wrap = true
        vim.wo.linebreak = true
    end
})


--airlines
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g["airline#extensions#tabline#show_buffers"] = 1

--vim-lion
vim.g["lion_squeeze_spaces"] = 1

--Floaterm
vim.g["floaterm_title"] = "Terminal($1/$2)"

--themes
vim.g["airline_theme"] = "kolor"
vim.cmd("colorscheme dracula")

require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "lua", "rust", "toml", "zig", "python", "haskell"},
    highlight = {
        enable = true,
    },
}

--LSP
local on_attach = function(client, bufnr)
    --Enables completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    -- See ":help vim.lsp.*" for documentation on any of the below functions
    remapb(bufnr, "n", "<Space>e",  "<cmd>lua vim.diagnostic.open_float()<CR>",  nrnso)
    remapb(bufnr, "n", "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>",     nrnso)
    remapb(bufnr, "n", "gr",        "<cmd>lua vim.lsp.buf.references()<CR>",     nrnso)
    remapb(bufnr, "n", "K",         "<cmd>lua vim.lsp.buf.hover()<CR>",          nrnso)
    remapb(bufnr, "n", "<Space>s",  "<cmd>lua vim.lsp.buf.signature_help()<CR>", nrnso)
    remapb(bufnr, "n", "<Space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",         nrnso)
    remapb(bufnr, "n", "<Space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",    nrnso)
    remapb(bufnr, "n", "<Space>f",  "<cmd>lua vim.lsp.buf.formatting()<CR>",     nrnso)
end

local servers = {"clangd", "pylsp", "pyright", "rust_analyzer", "zls", "hls"}

for _, lsp in pairs(servers) do

    -- Boilerplate for completion
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
                mod = "symbol_text"
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
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    require("lspconfig")[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities
    }

end
