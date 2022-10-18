remap  = vim.api.nvim_set_keymap
remapb = vim.api.nvim_buf_set_keymap

--settings
require("settings")

--remaps
nro = {noremap = true} --noremap option
so  = {silent = true}  --silent option
nrnso = {noremap = true, silent = true} --noremap and silent opton
require("remaps")

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

--customization
require("customization")

--treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "lua", "rust", "toml", "zig", "python", "haskell"},
    highlight = {
        enable = true,
    },
}

--LSP
require("lsp")
