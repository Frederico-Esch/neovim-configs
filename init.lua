require("settings")
require("simple_remaps")
require("plugin_manager")
require("my_commands")

colors, telescope_colors, theme = require("colors").get_colors()


vim.cmd.colorscheme(theme)
