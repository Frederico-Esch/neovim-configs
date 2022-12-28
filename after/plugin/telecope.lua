local builtin = require("telescope.builtin")
local remap = vim.keymap.set
local options = { silent = true, noremap = true }

remap("n", "<leader>ff", builtin.find_files , options)
remap("n", "<leader>bb", builtin.buffers    , options)
remap("n", "<leader>gf", builtin.git_files  , options)
remap("n", "<leader>ne", builtin.diagnostics, options)

for hl, col in pairs(telescope_colors) do
    vim.api.nvim_set_hl(0, hl, col)
end

require("telescope").setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            prompt_prefix = "   ",
            selection_caret = "➬  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 30,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = { "node_modules", "target", "build" },
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = { "truncate" },
            winblend = 0,
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    }
}
