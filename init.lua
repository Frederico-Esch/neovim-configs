colors, telescope_colors, theme = require("colors").get_colors()

require("settings")
require("plugin_manager")
require("remaps")
require("commands")

vim.cmd.colorscheme(theme.Neovim)
-- Highlights for scopes
vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" }) --Has to be done after setting colorscheme
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "RainbowPurple", { link = "Keyword" })
-- Highlight fixes for blink.cmp
vim.api.nvim_set_hl(0, "BlinkCmpKind", { bg = none })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { bg = none })
