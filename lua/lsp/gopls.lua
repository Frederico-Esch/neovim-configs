local config = require'lsp.general_config'

local gopls_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}


return gopls_config
