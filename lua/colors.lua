local colors = {
    white = "#CED4DF",
    darker_black = "#05080E",
    black = "#0B0E14",
    blackest_gravel = "#141413",
    gravel = "#857F78",
    dirtyblonde = "#F4CF86",
    taffy = "#FF2C4B",
    saltwatertaffy = "#8CFFBA",
    tardis = "#0A9DFF",
    tardis_dark = "#032338",
    yellow = "#E7C547",
    toffee = "B88853",
}

local telescope_colors = {
    TelescopeBorder = {
        fg = colors.blackest_gravel,
        bg = colors.blackest_gravel,
    },

    TelescopePromptBorder = {
        fg = colors.tardis_dark,
        bg = colors.tardis_dark,
    },

    TelescopePromptNormal = {
        fg = colors.white,
        bg = colors.tardis_dark,
    },

    TelescopePromptPrefix = {
        fg = colors.taffy,
        bg = colors.tardis_dark,
    },

    TelescopeNormal = { bg = colors.blackest_gravel },

    TelescopePreviewTitle = {
        fg = colors.black,
        bg = colors.tardis,
    },

    TelescopePromptTitle = {
        fg = colors.black,
        bg = colors.taffy,
    },

    TelescopeResultsTitle = {
        fg = colors.blackest_gravel,
        bg = colors.blackest_gravel,
    },

    TelescopeSelection = { bg = colors.tardis_dark, fg = colors.tardis },

    TelescopeResultsDiffAdd = {
        fg = colors.tardis,
    },

    TelescopeResultsChange = {
        fg = colors.dirtyblonde,
    },

    TelescopeResultsDelete = {
        fg = colors.taffy,
    },
}

local theme = {
    Neovim = [[badwolf]],
    LuaLine = [[powerline_dark]]
}

--vim.opt.bg = "dark"
vim.g["lion_squeeze_spaces"] = 1

get_colors = function()
    return colors, telescope_colors , theme
end

return {
    get_colors = get_colors
}
