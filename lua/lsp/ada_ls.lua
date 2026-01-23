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
--vim.g.AdaConfigured = false
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.name == "ada_ls" and client.config.settings.ada.projectFile == "" then --not vim.g.AdaConfigured then
            vim.g.AdaConfigured = true
            local files = vim.call("glob", vim.call[[getcwd]] .. "/*")
            local projectFile = string.gmatch(files, "([^%s]+%.gpr)")()


            if projectFile ~= nil then
                als_config.projectFile = projectFile
                vim.lsp.config['ada_ls'] = als_config

                local config = client.config
                client.stop()
                lspconfig.config(client.name,config)
                config.settings.ada.projectFile = projectFile
                local new_client_id = lspconfig.start_client(config)
                lspconfig.buf_attach_client(0, new_client_id)
            end
        end
    end
})

vim.lsp.config['ada_ls'] = als_config
return als_config
