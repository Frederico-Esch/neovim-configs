vim.api.nvim_create_user_command(
    "GenCtags",
    function(args)
        if genctags_ignore_paths == nil then
            genctags_ignore_paths = 'build'
        end
        if genctags_kinds == nil then
            genctags_kinds = [[--C++-kinds=+psxz --C-kinds=+psxz --fields=+iarzS --extras=+q]]
        end
        if genctags_default_language_force == nil then
            genctags_default_language_force = "--language-force=C"
        end

        local language_force = (args[1] == nil) and genctags_default_language_force or args[1]
        local dir = vim.call[[getcwd]]

        --print(vim.call('fnamemodify', dir, ""))
        --print(vim.call('fnamemodify', dir, ":p"))

        --I need to fix a bunch of things here:
        -- -filtering for c,h,cpp but not hpp
        -- -using gcc won't work for ANYTHING other than c lmao
        -- -language force should have a custom behaviour for other languages
        local paths_to_ignore = dir .. "/" .. genctags_ignore_paths
        local files = vim.fn.system("find " .. dir .. " -path " .. paths_to_ignore .. [[ -prune -o -regex ".*\.\(c\|h\|cpp\)" -print]], true)
        if files ~= "" then
            local files = files:gsub("\n", " "):match("^%s*(.-)%s*$")
            --print(files)
            --print([[gcc -M "]] .. files ..[[" | sed -e 's/[\\ ]/\n/g' | sed -e '/\.[oc]:\?\s*$\|^$/d']])

            local deps = vim.fn.system([[gcc -M ]] .. files ..[[ | sed -e 's/[\\ ]/\n/g' | sed -e '/\.[oc]:\?\s*$\|^$/d']]):gsub("\n", " ")
            local cmd = [[ctags ]] .. language_force .. " " .. genctags_kinds .. " " .. deps .. [[]]
            vim.fn.system(cmd)
        else
            print("No c files to generate tags")
        end
    end,
    {}
)
