return {
    { 'sjl/badwolf' },
    { 'wadackel/vim-dogrun' },
    { 'dracula/vim' },
    { 'jaredgorski/SpaceCamp' },
    { 'hachy/eva01.vim' },
    { 'EdenEast/nightfox.nvim' },
    { 'srcery-colors/srcery-vim' },
    { 'navarasu/onedark.nvim', opts = { style = 'deep' } },
    { 'tiagovla/tokyodark.nvim', opts = {
        transparent_background = vim.g.transparent_enabled,
        gamma = 0.8,
        styles = {
            comments = { bold = false, italic = true },
            keywords = { bold = false, italic = true },
            identifiers = { bold = false, italic = true },
            functions = { bold = true, italic = false },
            variables = { },
        },
        terminal_colors = true
        }
    },
    { 'ribru17/bamboo.nvim', opts = {
            style = 'vulgaris',
            toggle_style_key = nil,
            toggle_style_list = { 'vulgaris' },
            transparent = vim.g.transparent_enabled,
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
    },
}

--        --use 'eemed/sitruuna.vim'
--        use 'sjl/badwolf'
--        use 'wadackel/vim-dogrun'
--        use 'dracula/vim'
--        use 'jaredgorski/SpaceCamp'
--        use 'hachy/eva01.vim'
--        use 'EdenEast/nightfox.nvim'
--        use 'srcery-colors/srcery-vim'
--        use 'navarasu/onedark.nvim'
--        use 'tiagovla/tokyodark.nvim'
--        use 'ribru17/bamboo.nvim'
