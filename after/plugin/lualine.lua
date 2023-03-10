--local status = require"nvim-spotify".status

--status::start()

require"lualine".setup {
    options = { theme = theme.LuaLine },
    sections = {lualine_a = { "mode" }, lualine_x = {}},
    tabline = { lualine_a = { "buffers" }, lualine_z = { "tabs" } }
}
