local config = require'lsp.general_config'

local csharp_config = {
    on_attach = config.on_attach,
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}

vim.lsp.config['csharp_ls'] = csharp_config
-- CHECK THIS https://github.com/GustavEikaas/easy-dotnet.nvim
return csharp_config
