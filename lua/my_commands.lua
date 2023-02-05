vim.api.nvim_create_user_command(
    "IncreaseFontGui",
    function(args)
        if vim.g.neovide then
            vim.opt.guifont = { "", ":h"..args.args }
        end
    end,
    {nargs = 1}
)
