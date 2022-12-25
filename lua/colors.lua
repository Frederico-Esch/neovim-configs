function SetColorScheme(colorScheme)

    colorScheme = colorScheme or "default"
    vim.cmd.colorscheme(colorScheme)

    --vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})

end

--themes
-- vim        | airlines
-- badwolf    | badwolf, base16_colors, dark
-- deep-space | ayu_mirage
-- dogrun     | angr, kolor
-- dracula    | dracula, kolor
-- purify     | angr, kolor
-- sitruuna   | raven
-- sonokai    | deus

SetColorScheme("badwolf")
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g["airline#extensions#tabline#show_buffers"] = 1
vim.g["airline_theme"] = "ayu_mirage"
