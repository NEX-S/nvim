
local api = vim.api

api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    once = true,
    callback = function ()

        local utils = require "utils"

        local match_char_tbl = {
            ["'"] = "'",
            ['"'] = '"',
            ["`"] = "`",
            ["("] = ")",
            ["{"] = "}",
            ["["] = "]",
            ["<"] = ">",
        }

        local quote_tbl = { '"', "'", "`" }
        for i = 1, #quote_tbl do
            local char = quote_tbl[i]
            vim.keymap.set("i", char, function ()
                -- elseif char_rgt:match("[^%s|%)%]%}]") then

                local line_str = api.nvim_get_current_line()

                local char_rgt = utils.get_cursor_content(1, 1)
                local char_cnt = utils.get_char_num(line_str, char)

                if char_rgt == char then
                    return "<RIGHT>"
                elseif char_rgt:match("%a") then
                    return char
                elseif char_cnt % 2 == 0 then
                    return char .. char .. "<LEFT>"
                end

                return char
            end, { expr = true })
        end

        local left_bracket_tbl = { "(", "[", "{" }
        for i = 1, #left_bracket_tbl do
            local char = left_bracket_tbl[i]
            vim.keymap.set("i", char, function ()

                local line_str = api.nvim_get_current_line()

                local match_char = match_char_tbl[char]
                local right_char = utils.get_cursor_content(1, 1)

                local input_char_cnt = utils.get_char_num(line_str, char)
                local match_char_cnt = utils.get_char_num(line_str, match_char)

                if match_char_cnt > input_char_cnt or right_char:match("[%a|\"'`%(%[%{]") then
                    return char
                elseif input_char_cnt >= match_char_cnt then
                    return char .. match_char .. "<LEFT>"
                end

                print("Here")

                return char
            end, { expr = true })
        end

        local right_bracket_tbl = { ")", "]", "}", ">" }
        for i = 1, #right_bracket_tbl do
            local char = right_bracket_tbl[i]
            vim.keymap.set("i", char, function ()
                local right_char = utils.get_cursor_content(1, 1)

                if char == right_char then
                    return "<RIGHT>"
                end

                return char
            end, { expr = true })
        end

        local special_map = {
            ["<"] = function ()
                local cursorline = api.nvim_get_current_line()
                local right_char = utils.get_cursor_content(1, 1)

                if cursorline:match("[(if)=]") or right_char:match("%a") then
                    return "<"
                end

                return "<><LEFT>"
            end,
            ["<CR>"] = function ()
                local right_char = utils.get_cursor_content(1, 1)

                if right_char:match("[%]%}]") then
                    return "<CR><ESC>O"
                end

                return "<C-x><CR>"
            end,
            ["<BS>"] = function ()
                local cursorleft_char = utils.get_cursor_content(0, 0)
                local left_match_char = match_char_tbl[cursorleft_char]

                if left_match_char ~= nil and left_match_char == utils.get_cursor_content(1, 1) then
                    local cursorline_str = api.nvim_get_current_line()

                    local left_char_cnt  = utils.get_char_num(cursorline_str, cursorleft_char)
                    local match_char_cnt = utils.get_char_num(cursorline_str, left_match_char)

                    if left_char_cnt <= match_char_cnt then
                        return "<BS><DEL>"
                    end
                end

                return "<BS>"
            end,
        }

        for lhs, rhs in pairs(special_map) do
            vim.keymap.set("i", lhs, rhs, { expr = true })
        end

    end
})


