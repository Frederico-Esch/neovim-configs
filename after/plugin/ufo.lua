local ufo       = require'ufo'

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

ufo.setup({
    enable_get_fold_virt_text = true,
    provider_selector = function(bufnr, filetype, buftype) --maybe not use this?
        return {'treesitter', 'indent'}
    end,
    --[[ folding on regions c++
(
  (preproc_call
    directive: (_) @_dir
    argument: (_) @_arg_begin
    (#match? @_arg_begin "region*")) @_beg_region
  (_)*  @inner
  (preproc_call
    directive: (_) @_dir
    argument: (_) @_arg_end
    (#eq? @_arg_end "endregion")
    ) @_end_region
  (#eq? @_dir "#pragma")
  (#make-range! "fold" @_beg_region @_end_region)
)
    --]]
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate, ctx)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
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
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
    end,
    preview = {
        win_config = {
            border = "single"
        }
    }
}) --BETTER FOLDING
