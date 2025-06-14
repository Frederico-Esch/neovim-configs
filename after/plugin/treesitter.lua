require 'nvim-treesitter.install'.compilers = { "clang" }
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "rust",
        "toml",
        "zig",
        "python",
        "haskell",
        "json",
        "go",
        "odin",
        "query",
        "vim",
        "vimdoc",
        "ada",
        "cmake"
    },

    highlight = {
        enable = true,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = false,
            scope_incremental = false,
            node_incremental = "<Leader>n",
            node_decremental = "<Leader>N",
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = false,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["a/"] = { query = "@comment", query_group = "highlights" },
            },
            selection_modes = {
                ['@function.outer'] = 'v',
                ['@function.inner'] = 'v',
                ['@class.outer'] = 'v',
                ['@class.inner'] = 'v',
                ['@comment'] = 'v',
            },
            include_surrounding_whitespace = false,
        },
        swap = { enable = false }, --too grainy, I'll probably prefer to use normal motions instead of this
        move = { enable = false }, --too grainy, easy motions solves this much better
    }
}

-- shameless copy: https://github.com/Wansmer/nvim-config/blob/main/lua/modules/foldtext.lua
local function parse_line(linenr)
  local bufnr = vim.api.nvim_get_current_buf()

  local line = vim.api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, false)[1]
  if not line then
    return nil
  end

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok then
    return nil
  end

  local query = vim.treesitter.query.get(parser:lang(), "highlights")
  if not query then
    return nil
  end

  local tree = parser:parse({ linenr - 1, linenr })[1]

  local result = {}

  local line_pos = 0


  for id, node, metadata in query:iter_captures(tree:root(), 0, linenr - 1, linenr) do
    local name = query.captures[id]
    local start_row, start_col, end_row, end_col = node:range()

    local priority = tonumber(metadata.priority or vim.highlight.priorities.treesitter)

    if node:type() == "preproc_directive" then --pragma regions are bizarre
        local parent = node:parent()
        local args = parent:child(1)
        local sr, sc, er, ec = args:range()
        sc = sc + 1
        local arg_str = line:sub(sc, -1)

        if arg_str:find(" ") ~= nil then --region Name thingy
            local idx, _ = arg_str:find(" ")
            idx = idx
            table.insert(result, { arg_str:sub(0, idx), { {"@comment.c", 100 } }, range = { 0, idx }})
            table.insert(result, { arg_str:sub(idx+1, -1), { {"@constant.c", 100 } }, range = { idx, #arg_str }})
        else
            --table.insert(result, { line:sub(sc, -1), { {"@comment.c", 100 } }, range = { sc, #line }}) --Show endregion
        end
    elseif start_row == linenr - 1 and end_row == linenr - 1 then
      -- check for characters ignored by treesitter
      if start_col > line_pos then
        table.insert(result, {
          line:sub(line_pos + 1, start_col),
          { { "Folded", priority } },
          range = { line_pos, start_col },
        })
      end
      line_pos = end_col

      local text = line:sub(start_col + 1, end_col)
      table.insert(result, { text, { { "@" .. name, priority } }, range = { start_col, end_col } })
    end

  end

  local i = 1
  while i <= #result do
    -- find first capture that is not in current range and apply highlights on the way
    local j = i + 1
    while j <= #result and result[j].range[1] >= result[i].range[1] and result[j].range[2] <= result[i].range[2] do
      for k, v in ipairs(result[i][2]) do
        if not vim.tbl_contains(result[j][2], v) then
          table.insert(result[j][2], k, v)
        end
      end
      j = j + 1
    end

    -- remove the parent capture if it is split into children
    if j > i + 1 then
      table.remove(result, i)
    else
      -- highlights need to be sorted by priority, on equal prio, the deeper nested capture (earlier
      -- in list) should be considered higher prio
      if #result[i][2] > 1 then
        table.sort(result[i][2], function(a, b)
          return a[2] < b[2]
        end)
      end

      result[i][2] = vim.tbl_map(function(tbl)
        return tbl[1]
      end, result[i][2])
      result[i] = { result[i][1], result[i][2] }

      i = i + 1
    end
  end

  return result
end

function HighlightedFoldtext()
  local result = parse_line(vim.v.foldstart)
  if not result then
    return vim.fn.foldtext()
  end

  local folded = {
    { ' 󰁂 ' .. vim.v.foldend - vim.v.foldstart .. ' ', "FoldedText" },
  }

  for _, item in ipairs(folded) do
    table.insert(result, item)
  end

  local result2 = parse_line(vim.v.foldend)
  if result2 and #result2 > 0 then
    local first = result2[1]
    result2[1] = { vim.trim(first[1]), first[2] }
    for _, item in ipairs(result2) do
      table.insert(result, item)
    end
  end

  return result
end

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.HighlightedFoldtext()"

