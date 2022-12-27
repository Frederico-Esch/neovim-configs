local remap = vim.keymap.set

local options = { silent = true, noremap = true }
remap("n", "<s-tab>", ":bn<cr>", options)
remap("n", "<s-w>"  , ":bd<cr>", options)
remap("n",   "<c-h>",  "<c-w>h", options)
remap("n",   "<c-j>",  "<c-w>j", options)
remap("n",   "<c-k>",  "<c-w>k", options)
remap("n",   "<c-l>",  "<c-w>l", options)
