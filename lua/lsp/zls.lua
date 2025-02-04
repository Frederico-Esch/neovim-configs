local config = require'lsp.general_config'

local zls_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    settings = {
        zls = {
            enable_build_on_save = true
        }
    },
    capabilities = config.capabilities,
}


return zls_config
