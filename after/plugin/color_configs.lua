require('onedark').setup { style = 'deep' }

require('tokyodark').setup({
    transparent_background = false,
    gamma = 0.8,
    styles = {
        comments = { bold = false, italic = true },
        keywords = { bold = false, italic = true },
        identifiers = { bold = false, italic = true },
        functions = { bold = true, italic = false },
        variables = { },
    },
    terminal_colors = true
})

require('bamboo').setup {
    style = 'vulgaris',
    toggle_style_key = nil,
    toggle_style_list = { 'vulgaris' },
    transparent = false,
    dim_inactive = true,
    term_colors = true,
    ending_tildes = false,
    cmp_itemkind_reverse = false,

    code_style = {
        comments = { italic = true },
        conditionals = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        namespaces = { italic = true, bold = true },
        parameters = { },
        strings = { italic = true },
        variables = { },
    },

    lualine = {
        transparent = true,
    },

    colors = {},
    highlights = {},

    diagnostics = {
        darker = true,
        undercurl = false,
        background = false,
    },
}

_, _, theme = require('colors').get_colors()
vim.cmd.colorscheme(theme.Neovim)
