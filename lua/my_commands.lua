vim.api.nvim_create_user_command(
    "IncreaseFontGui",
    function(args)
        if vim.g.neovide then
            vim.opt.guifont = { "", ":h"..args.args }
        end
    end,
    {nargs = 1}
)

vim.api.nvim_create_user_command(
    "MinGWFixCompileDB",
    function(args)
        if table.getn(vim.lsp.buf_get_clients()) == 0 then return end
        if vim.lsp.buf_get_clients()[1].name ~= 'clangd' then return end

        local path = vim.lsp.buf.list_workspace_folders()[1] .. "/compile_commands.json"
        vim.fn.setqflist({ {filename = path, lnum = 1} }, 'r')
        vim.cmd.cdo[[%s/\/e/e:/g]]
        vim.cmd.cdo[[%s/[A-z0-9/]\{-}\(.\{2,3}\).exe/\1]]
        vim.cmd.cdo[[w]]
        vim.cmd.cdo[[bd]]
    end,
    {nargs = 0}
)

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank { higroup='Substitute' }
    end
})

vim.api.nvim_create_autocmd("Syntax", {
    desc = "Fix the <leader> remaps in ada",
    group = vim.api.nvim_create_augroup("ada-remap-fix", { clear = true }),
    callback = function(args)
        if(args.match == "ada") then
            local filename = vim.call("fnamemodify", args.file, ":t")
            vim.keymap.del("i", "<Space>aj", { buffer = args.buf })
            vim.keymap.del("i", "<Space>al", { buffer = args.buf })
        end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Linewrapping for latex files",
    group = vim.api.nvim_create_augroup("latex-wrapping", { clear = true}),
    callback = function(args)
        if args.match == "tex" then
            vim.o.textwidth = 0
            vim.o.wrap = true
            vim.o.linebreak = true
            --vim.o.columns = 120
        end
    end
})
