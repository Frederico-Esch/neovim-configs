local config = require'lsp.general_config'

local ols_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    init_options = {
        enable_format = false,
        enable_document_symbols = true,
        enable_semantic_tokens = true,
        enable_snippets = true,
        enable_references = true,
        enable_fake_methods = false,
        enable_inlay_hints = true,
        enable_procedure_snippet = true,
        enable_rename = true,
        verbose = true
    },
    capabilities = config.capabilities
}

vim.lsp.config['ols'] = ols_config
return ols_config
