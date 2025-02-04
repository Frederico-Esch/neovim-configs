local ufo = require'ufo'

local config = {}

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
client_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities) --BETTER FOLDING
config.capabilities = capabilities

local remap = vim.keymap.set
--Attach function
function on_attach(client, bufnr)
    local options = {
        noremap = true,
        silent  = true,
        buffer  = bufnr
    }

    remap("n"  , "gd"        , "<cmd>lua vim.lsp.buf.definition()<CR>"   , options)
    remap("n"  , "gD"        , "<cmd>lua vim.lsp.buf.declaration()<CR>"  , options)
    remap("n"  , "gr"        , "<cmd>lua vim.lsp.buf.references()<CR>"   , options)
    remap("n"  , "<leader>e" , "<cmd>lua vim.diagnostic.open_float()<CR>", options)
    remap("n"  , "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>"  , options)
    remap("n"  , "<leader>f" , "<cmd>lua vim.lsp.buf.format()<CR>"       , options)
    remap("n"  , "K"         ,
        function()
            if not ufo.peekFoldedLinesUnderCursor() then
                vim.lsp.buf.hover()
            end
        end,
    options)
    remap("n"  , "<leader>rn",
        function()
             vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
                callback = function()
                    local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
                    vim.api.nvim_feedkeys(key, "c", false)
                    vim.api.nvim_feedkeys("0", "n", false)
                    return true
                end,
            })
            vim.lsp.buf.rename()
        end,
    options)
end
config.on_attach = on_attach

config.debounce_text_changes = 150

return config
