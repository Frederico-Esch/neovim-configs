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
