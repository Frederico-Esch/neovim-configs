vim.g["floaterm_title"] = "Terminal($1/$2)"
vim.cmd("hi Floaterm guibg=black")
vim.g.floaterm_position = 'bottomright'

local remap = vim.keymap.set

remap("n", "<s-t>", ":FloatermToggle <CR>", { silent = true, noremap = true })
