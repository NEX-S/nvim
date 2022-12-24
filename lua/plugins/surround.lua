
local api = vim.api

api.nvim_create_autocmd("ModeChanged", {
    pattern = { "n:v", "n:V" },
    once = true,
    callback = function ()
        -- ADD SURROUND
        local function add_surround (left_char, rght_char)

            local mode = api.nvim_get_mode().mode

            local s_pos = vim.fn.getpos("v")
            local e_pos = vim.fn.getpos(".")

            if left_char:match("[%]%}%)]") then
                left_char, rght_char = rght_char, left_char
            end

            if mode == "v" then
                if e_pos[3] < s_pos[3] then
                    s_pos, e_pos = e_pos, s_pos
                end
            elseif mode == "V" then
                local line_str = api.nvim_get_current_line()
                s_pos[3] = line_str:find("[^%s]")
                e_pos[3] = #line_str
            end

            api.nvim_buf_set_text(0, s_pos[2] - 1, s_pos[3] - 1, s_pos[2] - 1, s_pos[3] - 1, { left_char })
            api.nvim_buf_set_text(0, e_pos[2] - 1, e_pos[3] + 1, e_pos[2] - 1, e_pos[3] + 1, { rght_char })
        end

        local surround_map = {
            ['"'] = '"',
            ["'"] = "'",
            ["`"] = "`",
            ["("] = ")",
            ["["] = "]",
            ["{"] = "}",
            [")"] = "(",
            ["]"] = "[",
            ["}"] = "{",
        }

        for left_char, right_char in pairs(surround_map) do
            vim.keymap.set("x", left_char, function ()
                add_surround(left_char, right_char)
            end, { remap = false, silent = false })
        end

        -- CHANGE SURROUND
        local function change_surround (char)
            local s_pos = vim.fn.getpos("v")
            local e_pos = vim.fn.getpos(".")

            local surround_map = {
                ['"'] = '"',
                ["'"] = "'",
                ["`"] = "`",
                ["("] = ")",
                ["["] = "]",
                ["{"] = "}",
                [")"] = "(",
                ["]"] = "[",
                ["}"] = "{",
            }

            local left_char = char
            local rght_char = surround_map[char]

            local mode = api.nvim_get_mode().mode
            if mode == "v" then
                if e_pos[3] < s_pos[3] then
                    s_pos, e_pos = e_pos, s_pos
                end
            elseif mode == "V" then
                local line_str = api.nvim_get_current_line()
                s_pos[3] = line_str:find("[^%s]")
                e_pos[3] = #line_str
            end

            api.nvim_buf_set_text(0, s_pos[2] - 1, s_pos[3] - 1, s_pos[2] - 1, s_pos[3] - 0, { left_char })
            api.nvim_buf_set_text(0, e_pos[2] - 1, e_pos[3] - 1, e_pos[2] - 1, e_pos[3] + 0, { rght_char })
        end

        local change_map = {
            ['c"'] = '"',
            ["c'"] = "'",
            ['c`'] = "`",
            ['c('] = '(',
            ["c["] = "[",
            ['c{'] = "{",
            ['c)'] = '(',
            ["c]"] = "[",
            ['c}'] = "{",
        }

        for lhs, rhs in pairs(change_map) do
            vim.keymap.set("x", lhs, function ()
                change_surround(rhs)
            end)
        end
    end
})
