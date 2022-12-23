
local api = vim.api

api.nvim_create_autocmd("CmdLineEnter", {
    pattern = "*",
    once = true,
    callback = function ()
        local function align (table)

            local align_char = table.args

            line_s = vim.fn.getpos("'<")[2]
            line_e = vim.fn.getpos("'>")[2]

            local line_tbl = api.nvim_buf_get_lines(0, line_s - 1, line_e, false)

            local max_pos = 0
            local char_pos = 0
            for i = 1, #line_tbl do
                if line_tbl[i] ~= "" then
                    char_pos = line_tbl[i]:find(align_char) or 0
                    max_pos = max_pos < char_pos and char_pos or max_pos
                end
            end

            local spc_str = ""
            for i = 1, #line_tbl do
                char_pos = line_tbl[i]:find(align_char)
                if char_pos ~= nil then
                    spc_str = string.rep(' ', max_pos - char_pos)
                    api.nvim_buf_set_text(0, line_s + i - 2, char_pos - 1, line_s + i - 2, char_pos - 1, { spc_str } )
                end
            end

        end

        api.nvim_create_user_command("A", align, {
            nargs = 1,
            range = '%',
            complete = function ()
                return { "=", "{" }
            end,
        })
    end
})
