--airlines
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g["airline#extensions#tabline#show_buffers"] = 1

--vim-lion
vim.g["lion_squeeze_spaces"] = 1

--Floaterm
vim.g["floaterm_title"] = "Terminal($1/$2)"
vim.cmd("hi Floaterm guibg=black")
vim.g.floaterm_position = 'bottomright'

--themes
-- vim        | airlines
-- badwolf    | badwolf, base16_colors, dark
-- deep-space | ayu_mirage
-- dogrun     | angr, kolor
-- purify     | angr
-- sitruuna   | raven
-- sonokai    | deus
vim.g["airline_theme"] = "raven"
vim.cmd("colorscheme sitruuna")
--vim.cmd("hi Normal guibg=none")

