--deprecate ufo
local ufo       = require'ufo'

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local isWhitespace = function(s)
    return s:match("[^%s]") == nil
end
local isPragma = function(s)
    return s == "#pragma"
end
local isEndregion = function(s)
    return s == "endregion"
end

ufo.setup({
    enable_get_fold_virt_text = true,
    provider_selector = function(bufnr, filetype, buftype) --maybe not use this?
        return {'treesitter', 'indent'}
    end,
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate, ctx)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        local begin = false
        local hadPragma = false
        for _, chunk in ipairs(virtText) do
            hadPragma = isPragma(chunk[1]) or hadPragma
            if begin or (not isPragma(chunk[1]) and not (hadPragma and isWhitespace(chunk[1]))) then
                begin = true
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
        end

        table.insert(newVirtText, {suffix, 'MoreMsg'}) --middle

        begin = false
        for _, v in ipairs(ctx.get_fold_virt_text(endLnum)) do
            if begin or (not isWhitespace(v[1]) and not isPragma(v[1]) and not isEndregion(v[1])) then
                begin = true
                table.insert(newVirtText, v)
            end
        end

        return newVirtText
    end,
    preview = {
        win_config = {
            border = "single"
        }
    }
}) --BETTER FOLDING
