--markdown
--remap("n", "<Space>co", ":FloatermNew --silent --disposable pandoc -s -M pagetitle=\"roteiro\" --katex=\"D:\\\\Matérias\\\\Período 3\\\\fisica\\\\katex\\\\\" -o roteiro.html roteiro.md", {})
vim.api.nvim_create_autocmd("Filetype", {
    pattern  = {"markdown"},
    callback = function()
        remap("n", "<Space>co", ":FloatermNew --silent pandoc -s -M pagetitle=\"%<\" --katex=\"./katex/\" -o %<.html %", {}) -- %:p:s?[^/]*\\.[^/]*??
        vim.wo.wrap = true
        vim.wo.linebreak = true
    end
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = {"arduino"},
    callback = function()
        remap("n", "<Space>co", ":FloatermNew --autoclose=0 /mnt/e/Progs/Processing/processing-4.0b1/processing-java.exe --sketch=%:p:h:s?/mnt/e?E:? --run<CR>", {}) --processing --sketch="E:/Programas/processing/projects/imageParticles" --run
    end
})

