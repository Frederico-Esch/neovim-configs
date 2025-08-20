local config = require'lsp.general_config'
--look into: https://git.light7734.com/light7734/dotfiles/src/branch/main/nvim/lsp/clangd.lua
--vim.lsp.enable("clangd") don't do this even though that's what enables the SwitchHeader

config.capabilities.offsetEncoding = { "utf-8", "utf-16" }
config.capabilities.textDocument.completion.editsNearCursor = true
local clangd_config = {
    on_attach = config.on_attach,
    cmd = { "clangd", "--header-insertion=never" },
    --cmd = { "clangd"},
    flags = {
        debounce_text_changes = config.debounce_text_changes,
    },
    capabilities = config.capabilities
}
table.insert(clangd_config.cmd, "--query-driver=**")
table.insert(clangd_config.cmd, "--fallback-style=webkit")
table.insert(clangd_config.cmd, "--background-index")
table.insert(clangd_config.cmd, "--cross-file-rename")

vim.lsp.config['clangd'] = clangd_config --LspRestart shouldn't mess with my config
return clangd_config
