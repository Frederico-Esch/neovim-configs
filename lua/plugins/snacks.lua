
return {
    'folke/snacks.nvim',
    lazy = false,
    opts = {
        indent = {
            indent = {
                enabled = true,
                char = "│",
                hl = "@comment",
            },
            animate = {
                enabled = false,
                style = "out",
                easing = "linear",
                duration = {
                    step = 20, -- ms per step
                    total = 500, -- maximum duration
                }
            },
            scope = {
                enabled = true,
                char = "│",
                hl = {
                    "RainbowRed",
                    "RainbowYellow",
                    "RainbowPurple",
                    "RainbowOrange",
                    "RainbowGreen",
                    "RainbowViolet",
                    "RainbowCyan",
                }
            },
            chunk = {
                enabled = true,
                only_current = false,
                hl = {
                    "RainbowYellow",
                    "RainbowPurple",
                    "RainbowOrange",
                    "RainbowGreen",
                    "RainbowViolet",
                    "RainbowCyan",
                    "RainbowRed",
                },
                char = {
                    -- corner_top = "┌",
                    -- corner_bottom = "└",
                    corner_top = "╭",
                    corner_bottom = "╰",
                    horizontal = "─",
                    vertical = "│",
                    arrow = ">",
                },
            },
        },

        input = { enabled = false },

        rename = { enabled = false },

        picker = {
            focus = "input", --list
            matcher = {
                file_pos = false,
            },
            win = {
                input = {
                    keys = {
                        ["<c-s>"] =  { "qflist", mode = { "i", "n" } },
                        ["s"] =  { "edit_split", mode = { "n" } },
                        ["v"] =  { "edit_vsplit", mode = { "n" } },
                        ["o"] =  { "edit_vsplit", mode = { "n" } }, --Discover how to not follow to assing to O
                    },
                },
                list = {
                    keys = {
                        ["a"] = "focus_input",
                        ["A"] = "focus_input",
                    }
                },
                previews = {
                    keys = {
                        ["a"] = "focus_input",
                        ["A"] = "focus_input",
                    }
                }
            },
        },

        explorer = {
            replace_netrw = true
        },

    },
    keys = {
        { "<leader>bs", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>lg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>ff", function() Snacks.picker.files({ ignored = true, hidden = true }) end, desc = "Find Files" },
        { "<leader>gf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<leader>pp", function() Snacks.picker.pickers() end, desc = "Pickers" }, --snacks
        { "<leader>qf", function() Snacks.picker.qflist() end, desc = "qflist" },
        { "<leader>ne", function() Snacks.picker.diagnostics() end, desc = "Next error" },
    }
}
