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
