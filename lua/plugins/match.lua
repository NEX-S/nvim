
local api = vim.api
local keymap = vim.keymap.set

local utils = require "utils"

local match_char_cnt = 0
keymap({ "n", "x" }, "m", function ()
    local cursor_char = utils.get_cursor_content(1, 1)

    local movmnt_char = match_char_cnt % 2 == 0 and "f" or "F"

    local match_map = {
        ["("] = "%", [")"] = "%",
        ["["] = "%", ["]"] = "%",
        ["{"] = "%", ["}"] = "%",
        ["'"] = movmnt_char .. cursor_char,
        ['"'] = movmnt_char .. cursor_char,
        ["`"] = movmnt_char .. cursor_char,
    }

    match_char_cnt = match_char_cnt + 1

    return match_map[cursor_char] or "%"

end, { expr = true, remap = true })

-- keymap({ 'n', 'v', 'o' }, "<SPACE>", ";", { silent = true })


-- vim.o.updatetime = 50
-- api.nvim_create_autocmd("CursorHold", {
--     callback = function ()
-- 
-- 
--         local char = utils.get_cursor_content(1,1)
-- 
--         -- local skip_contents = [[!empty(filter(map(synstack(line("."), col(".")), synIDattr(v:val, "name")), v:val =~? "string\\|character\\|singlequote\\|escape\\|symbol\\|comment"))]]
-- 
--         local pair_tbl = {
--             ["("] = ")",
--             [")"] = "(",
-- 
--             ["["] = "]",
--             ["]"] = "[",
-- 
--             ["{"] = "}",
--             ["}"] = "{",
-- 
--             ["<"] = ">",
--             [">"] = "<",
--         }
-- 
--         if char:match("[%(%{%[]") then
--             _p(vim.fn.searchpairpos(char, "", pair_tbl[char], "nW"))
--         elseif char:match("[%)%}%]]") then
--             _p(vim.fn.searchpairpos(char, "", pair_tbl[char], "bnW"))
--         end
-- 
--     end
-- })
-- 
-- TODO: TREESITTER HL MATCHPAREN
-- local function setHL ()
--     local cursor_pos = api.nvim_win_get_cursor(0)
--     local cursor_row = cursor_pos[1]
--     local cursor_col = cursor_pos[2]
-- 
--     local bufnr = api.nvim_get_current_buf()
--     ts_highlighter = vim.treesitter.highlighter.active[bufnr]
-- 
-- end
