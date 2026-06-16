_, _, theme = require('colors').get_colors()
local icons = require"icons"

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    opts = {
        options = {
            theme = theme.LuaLine
        },
        sections = {
            lualine_a = {
                {
                    "mode",
                    fmt = function (str)
                        return icons.ui.Circle .. str
                    end
                }
            },
            lualine_b = {
                {
                    "branch",
                    icon = icons.git.Branch
                },
                {
                    "diff",
                    diff_color = { added = {fg = '#98be65'}, modified = {fg = '#FF8800'}, removed = {fg = '#ec5f67'} },
                    symbols = {
                        added = icons.git.LineAdded,
                        modified = icons.git.LineModified,
                        removed = icons.git.LineRemoved
                    },
                },
                {
                    "diagnostics",
                    sources = { 'nvim_diagnostic' },
                    symbols = {
                        error = icons.diagnostics.BoldError,
                        warn = icons.diagnostics.BoldWarning,
                        info = icons.diagnostics.BoldInformation,
                        hint = icons.diagnostics.BoldHint
                    }
                }
            },
            lualine_c = {},
            lualine_x = {"filetype"}
        },
        tabline = {
            lualine_a = { "buffers" }
        }
    }
}
