if vim.g.transparent_enabled then
    vim.cmd[[TransparentGui]]
end

return {
    'xiyaowong/transparent.nvim',
    opts = {
        on_clear = function()
            vim.cmd[[TransparentGui]]
        end
    }
}

