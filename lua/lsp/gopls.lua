local config = require'lsp.general_config'

local gopls_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}

vim.lsp.config['gopls'] = gopls_config
return gopls_config
