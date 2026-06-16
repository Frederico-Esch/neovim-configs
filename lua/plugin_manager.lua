local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.pack.add({ 'https://github.com/folke/lazy.nvim' })
require("lazy").setup({
    spec = {
        { import = "plugins" }
    }
})
