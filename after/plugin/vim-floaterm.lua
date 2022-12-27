vim.g["floaterm_title"] = "Terminal($1/$2)"
vim.api.nvim_set_hl(0, "Floaterm", { bg = "black" })
--vim.cmd("hi Floaterm guibg=black")
vim.g.floaterm_position = 'bottomright'
vim.g.floaterm_shell    = 'powershell'

local remap = vim.keymap.set

remap("n", "<s-t>", ":FloatermToggle <CR>", { silent = true, noremap = true })
