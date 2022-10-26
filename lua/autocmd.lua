vim.api.nvim_create_autocmd("Filetype", {
    pattern  = {"markdown"},
    callback = function()
        remap("n", "<Space>co", ":FloatermNew --silent pandoc -s -M pagetitle=\"%<\" --katex=\"./katex/\" -o %<.html %", {})
        vim.wo.wrap = true
        vim.wo.linebreak = true
    end
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern  = {"c"},
    callback = function()
        remap("n", "<Space>co", ":FloatermNew --autoclose=0 gcc % && ./a.out<CR>", {})
        vim.wo.wrap = true
        vim.wo.linebreak = true
    end
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern  = {"cpp"},
    callback = function()
        remap("n", "<Space>co", ":FloatermNew --autoclose=0 g++ % && ./a.out<CR>", {})
        vim.wo.wrap = true
        vim.wo.linebreak = true
    end
})
