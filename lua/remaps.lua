local remap = vim.keymap.set

local options = { silent = true, noremap = true }
remap("n", "<s-tab>"   , ":bn<cr>"   , options)
remap("n", "<s-w>"     , ":bd<cr>"   , options)
remap("n", "<c-h>"     , "<c-w>h"    , options)
remap("n", "<c-j>"     , "<c-w>j"    , options)
remap("n", "<c-k>"     , "<c-w>k"    , options)
remap("n", "<c-l>"     , "<c-w>l"    , options)
remap("n", "<leader>rt", ":retab<CR>", options)
remap("i", "<C-n>", "<c-x><c-o>", options)
remap({"n", "v"}, "<A-k>", "<cmd>m .-2<cr>==", options)
remap({"n", "v"}, "<A-j>", "<cmd>m .+1<cr>", options)
remap("v", "<A-j>", ":m '>+1<cr>gv=gv", options)
remap("v", "<A-k>", ":m '<-2<cr>gv=gv", options)
remap("v", "<", "<gv", options)
remap("v", ">", ">gv", options)
