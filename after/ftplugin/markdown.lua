local api = vim.api
local utils = require "utils"

require"UI.x-color".set_hl {
    markdownH1 = { bg = "NONE", fg = "#C53B52" },
    markdownH2 = { bg = "NONE", fg = "#C53B52" },
    markdownH3 = { bg = "NONE", fg = "#C53B52" },
    markdownH4 = { bg = "NONE", fg = "#C53B52" },
    markdownH5 = { bg = "NONE", fg = "#C53B52" },
    markdownH6 = { bg = "NONE", fg = "#C53B52" },

    markdownError = { bg = "NONE", fg = "#ffffff" },
}

vim.defer_fn(function ()
    api.nvim_create_autocmd ("InsertEnter", {
        pattern = "*.md",
        once = true,
        callback = function ()
            vim.keymap.set("i", "`", function ()
                local line_str = api.nvim_get_current_line()

                local char_rgt = utils.get_cursor_content(1, 1)
                local char_cnt = utils.get_char_num(line_str, "`")

                if char_rgt == "`" then
                    return "<RIGHT>"
                elseif char_rgt:match("%a") then
                    return "`"
                elseif utils.get_cursor_content(-2, 0) == "``" then
                    return "`text<CR>```<UP><RIGHT><RIGHT><RIGHT><RIGHT><CR>"
                elseif char_cnt % 2 == 0 then
                    return "``<LEFT>"
                end

                return "`"
            end, { expr = true })
        end
    })

    vim.keymap.set("n", ";r", function ()
        local pos = api.nvim_win_get_cursor(0)[1] / api.nvim_buf_line_count(0)
        require "plugins.terminal".open_term_float("glow " .. vim.fn.expand("%"),
            { start_ins = false, resume = false, exit_key = ";q" },
            { title = " [ PREVIEW ]", title_pos = "right" }
        )
        vim.keymap.set("n", "<A-j>", function ()
            vim.cmd(tostring(math.floor(pos * api.nvim_buf_line_count(0))))
        end, { buffer = true })
    end)
end, 300)
