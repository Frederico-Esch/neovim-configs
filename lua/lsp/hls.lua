local config = require'lsp.general_config'

local hls_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}

vim.lsp.config['hls'] = hls_config
return hls_config;
