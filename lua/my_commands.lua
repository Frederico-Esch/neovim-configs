vim.api.nvim_create_user_command(
    "IncreaseFontGui",
    function(args)
        if vim.g.neovide then
            vim.opt.guifont = { "", ":h"..args.args }
        end
    end,
    {nargs = 1}
)

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
