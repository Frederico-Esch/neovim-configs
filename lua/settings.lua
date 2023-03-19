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
vim.g.mouse           = ""
vim.o.formatoptions   = ""
vim.o.ignorecase      = true
vim.o.smartcase       = true


vim.o.list            = true
vim.o.listchars       = "tab:➤ ,lead:·,trail:❤"


--remaps
vim.g.mapleader = " "

local remap = vim.keymap.set
local noremap_and_silent = { noremap = true, silent = true }

--buffer movement
remap("n",   "<s-w>", ":bd<CR>", noremap_and_silent)
remap("n", "<s-Tab>", ":bn<CR>", noremap_and_silent)

--window movement
remap("n",     "<c-h>",   "<c-w>h", noremap_and_silent)
remap("n",     "<c-j>",   "<c-w>j", noremap_and_silent)
remap("n",     "<c-k>",   "<c-w>k", noremap_and_silent)
remap("n",     "<c-l>",   "<c-w>l", noremap_and_silent)
remap("n", "<leader>m", ":Lex<CR>", noremap_and_silent)
