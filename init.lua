require("settings")
require("simple_remaps")
require("plugin_manager")

colors, telescope_colors, theme = require("colors").get_colors()

vim.cmd.colorscheme(theme)
