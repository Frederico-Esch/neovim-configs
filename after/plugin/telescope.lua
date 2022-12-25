local builtin = require("telescope.builtin")

local default_theme = "ivy"

require("telescope").setup{

    defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.65,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.8,
          height = 0.8,
          preview_cutoff = 10,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules", "build", "target" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    },

    pickers = {
        find_files = {
            theme = default_theme
        },
        buffers = {
            theme = default_theme
        },
        diagnostics = {
            theme = default_theme
        },
    }

}


local remap = vim.keymap.set

remap("n", "<leader>ff", builtin.find_files)
remap("n", "<leader>bb", builtin.buffers)
remap("n", "<leader>ne", function() builtin.diagnostics({ bufnr = 0 }) end)

