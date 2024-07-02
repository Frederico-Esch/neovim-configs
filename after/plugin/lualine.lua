--local status = require"nvim-spotify".status

--status::start()

local lualine = require"lualine"
local icons = require"icons"
local config = lualine.get_config()

config.options.theme = theme.LuaLine

config.sections = {
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
}

config.tabline = {
    lualine_a = { "buffers" },
    --lualine_z = { "tabs" }
}


lualine.setup(config)
