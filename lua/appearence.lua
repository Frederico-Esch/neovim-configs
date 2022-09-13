--vim-lion
vim.g["lion_squeeze_spaces"] = 1

--Floaterm
vim.g["floaterm_title"] = "Terminal($1/$2)"

--airlines
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g["airline#extensions#tabline#show_buffers"] = 1

--themes
-- vim        | airlines
-- badwolf    | badwolf, base16_colors, dark
-- deep-space | ayu_mirage
-- dogrun     | angr, kolor
-- purify     | angr
vim.cmd("colorscheme badwolf")
vim.g["airline_theme"] = "base16_colors"
