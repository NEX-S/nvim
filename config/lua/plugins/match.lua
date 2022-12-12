
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

keymap({ 'n', 'v', 'o' }, "<SPACE>",
    function ()
        local right_char = utils.get_cursor_content(1, 1)
        if right_char:match("['\"]") then
            match_char_cnt = match_char_cnt + 1
            return "f" .. right_char
        end
        return ";"
    end,
{ expr = true })


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
