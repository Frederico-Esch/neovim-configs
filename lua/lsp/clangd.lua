local config = require'lsp.general_config'

local clangd_config = {
    on_attach = config.on_attach,
    --cmd = { "clangd", "--header-insertion=never" },
    cmd = { "clangd"},
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}
table.insert(clangd_config.cmd, "--query-driver=**")
table.insert(clangd_config.cmd, "--fallback-style=webkit")
table.insert(clangd_config.cmd, "--compile-commands-dir=./build")

return clangd_config
