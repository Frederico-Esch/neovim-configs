--local status = require"nvim-spotify".status

--status::start()

local lualine = require"lualine"
local icons = require"icons"
local config = lualine.get_config()

config.options.theme = [[palenight]]

config.sections = {
    lualine_a = {
        {
            "mode",
            fmt = function (str)
                return (vim.g.have_nerd_font and icons.ui.Circle or "⎊ ") .. str
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
                added = vim.g.have_nerd_font and icons.git.LineAdded or "+",
                modified = vim.g.have_nerd_font and icons.git.LineModified or "#",
                removed = vim.g.have_nerd_font and icons.git.LineRemoved or "-"
            },
        },
        {
            "diagnostics",
            sources = { 'nvim_diagnostic' },
            symbols = {
                error = vim.g.have_nerd_font and icons.diagnostics.BoldError or "E",
                warn =  vim.g.have_nerd_font and icons.diagnostics.BoldWarning or "W",
                info =  vim.g.have_nerd_font and icons.diagnostics.BoldInformation or "I",
                hint =  vim.g.have_nerd_font and icons.diagnostics.BoldHint or "H"
            }
        }
    },
    lualine_c = {},
    lualine_x = { "filetype", }
}

config.tabline = {
    lualine_a = { "buffers", }
    --lualine_z = { "tabs" }
}


config.options.icons_enabled = vim.g.have_nerd_font

if not vim.g.have_nerd_font then
    config.options.component_separators = ''
    config.options.section_separators = { left = '', right = '' }
end

lualine.setup(config)
