local remap = vim.keymap.set

remap("n", "<leader>gg", ":Git<CR>", { silent = true, noremap = true })
