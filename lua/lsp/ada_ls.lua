local config = require'lsp.general_config'

local als_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    settings = {
        ada = {
            projectFile = "",
        }
    },
    capabilities = config.capabilities,
}

lspconfig = vim.lsp
vim.g.AdaConfigured = false
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.name == "ada_ls" and not vim.g.AdaConfigured then
            vim.g.AdaConfigured = true
            local files = vim.call("glob", vim.call[[getcwd]] .. "/*")
            local projectFile = string.gmatch(files, "([%a]+.gpr)")()

            if projectFile ~= nil then
                lspconfig.config(client.name,{
                    on_attach = on_attach,
                    flags = {
                        debounce_text_changes = 150,
                    },
                    capabilities = capabilities,
                    settings = {
                        ada = {
                            projectFile = projectFile
                        }
                    }
                })
            end
        end
    end
})

vim.lsp.config['ada_ls'] = als_config
return als_config
