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
vim.cmd("hi Normal guibg=0")

--Floaterm
vim.cmd("hi Floaterm guibg=black")
vim.g.floaterm_position = 'bottomright'
