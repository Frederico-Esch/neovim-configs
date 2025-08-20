local config = require'lsp.general_config'

local rust_analyzer_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}

vim.lsp.config['rust_analyzer'] = rust_analyzer_config
return rust_analyzer_config
