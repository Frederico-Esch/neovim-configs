vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g["airline#extensions#tabline#show_buffers"] = 1
vim.g["airline_theme"] = "badwolf"

--local status = require"nvim-spotify".status
--status::start()

vim.g["airline#parts#define_function"] = {'foo', 'status.listen'}