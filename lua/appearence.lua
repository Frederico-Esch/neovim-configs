--vim-lion
vim.g["lion_squeeze_spaces"] = 1

--Floaterm
vim.g["floaterm_title"] = "Terminal($1/$2)"

--airlines
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g["airline#extensions#tabline#show_buffers"] = 1

--special theme
vim.g.sonokai_style = 'maia'
vim.g.sonokai_better_performance = 1
vim.g.sonokai_disable_italic_comment = 1

--themes
-- vim        | airlines
-- badwolf    | badwolf, base16_colors, dark
-- deep-space | ayu_mirage
-- dogrun     | angr, kolor
-- purify     | angr
-- sitruuna   | raven
-- sonokai    | deus
vim.cmd("colorscheme sonokai")
vim.g["airline_theme"] = "deus"
