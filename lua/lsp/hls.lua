local config = require'lsp.general_config'

local hls_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}


return hls_config;
