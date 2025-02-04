local config = require'lsp.general_config'

local clangd_config = {
    on_attach = config.on_attach,
    --cmd = { "clangd", "--header-insertion=never" },
    cmd = { "clangd", "--fallback-style=webkit" },
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}
table.insert(clangd_config.cmd, "--query-driver=**")


return clangd_config
