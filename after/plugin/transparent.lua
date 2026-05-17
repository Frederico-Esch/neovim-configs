require("transparent").setup({
    on_clear = function()
        vim.cmd[[TransparentGui]]
    end,
})

if vim.g.transparent_enabled then
    vim.cmd[[TransparentGui]]
end
