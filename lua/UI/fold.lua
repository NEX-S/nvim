
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

local api = vim.api

local fold_opts = {
    foldenable   = true,

    foldminlines = 4,
    foldlevel    = 10,
    foldnestmax  = 10,

    foldcolumn   = '1',
    foldmethod   = "indent",
    foldtext     = "v:lua._fold_text()",
}

-- TODO: local listchars = {
--  xxx = xxx
-- }
-- for + opt:append

for key, value in pairs(fold_opts) do
    api.nvim_set_option_value(key, value, {})
end

local ns_id = api.nvim_create_namespace("fold_ns")

vim.keymap.set('n', ' ', function ()
    local sline = vim.v.foldstart
    local eline = vim.v.foldend

    local cline = api.nvim_win_get_cursor(0)[1]

    if sline ~= 0 and cline >= sline and cline <= eline then

        local indents = api.nvim_buf_get_lines(0, sline - 1, sline, true)[1]
        local fillpos = indents:find("[^%s]") - 3

        local opts = {
            id = sline,
            virt_text = { { '', "FoldClose" }, },
            virt_text_win_col = fillpos,
            virt_text_pos = "overlay",
        }

        -- if vim.fn.foldclosed(cline) == -1 then
        --     opts = {
        --         id = sline,
        --         virt_text = { { '', "FoldOpen" }, },
        --         virt_text_pos = "overlay",
        --     }
        -- end

        api.nvim_buf_set_extmark(0, ns_id, sline - 1, 0, opts)
    end

    api.nvim_command("silent!normal! za")
    api.nvim_command("redrawstatus")
    -- api.nvim_command("silent!mkview")
end, { expr = false })

function _G._fold_text ()
    local sline = vim.v.foldstart

    if sline ~= 0 then
        local string = api.nvim_buf_get_lines(0, sline - 1, sline, true)[1]

        local indent = string:find("%S") - 1

        return string.rep(' ', indent - 2) .. " " .. string:gsub("^%s*", '') .. " ⁄⁄⁄⁄ "
    end
end

api.nvim_create_autocmd("BufWinEnter", {
    command = "silent! loadview"
})

api.nvim_create_autocmd("BufWinLeave", {
    command = "silent! mkview"
})

-- TODO
-- api.nvim_create_autocmd("BufReadPost", {
--     callback = function ()
--         local ns_id = api.nvim_create_namespace("fold_ns")
--         local linecnt = api.nvim_buf_line_count(0)
-- 
--         if linecnt < 10000 then
--             for i = 1, linecnt do
--                 local foldlevel = vim.fn.foldlevel(i)
--                 local virtline = vim.fn.foldclosed(i)
-- 
--                 if foldlevel > 0 and virtline > 0 then
--                     local opts = {
--                         id = virtline,
--                         virt_text = { { '', "FoldClose" }, },
--                         virt_text_win_col = foldlevel * vim.bo.tabstop - 2,
--                         virt_text_pos = "overlay",
--                         hl_mode = "combine",
--                     }
-- 
--                     api.nvim_buf_set_extmark(0, ns_id, virtline - 1, 0, opts)
--                 end
--             end
--         end
--     end
-- })


-- TODO
-- vim.keymap.set('n', ' ', function ()
--     local sline = vim.v.foldstart
--     local eline = vim.v.foldend
-- 
--     local cline = api.nvim_win_get_cursor(0)[1]
-- 
--     if sline ~= 0 and cline >= sline and cline <= eline and vim.fn.foldclosed(cline) == -1 then
-- 
--         local indents = api.nvim_buf_get_lines(0, sline - 1, sline, true)[1]
--         local fillpos = indents:find("%S") - 3
-- 
--         local opts = {
--             id = sline,
--             virt_text = { { '>', "FoldOpen" }, },
--             virt_text_win_col = fillpos,
--             virt_text_pos = "overlay",
--         }
-- 
--         api.nvim_buf_set_extmark(0, ns_id, sline - 1, 0, opts)
--     end
-- 
--     api.nvim_command("silent!normal! za")
--     api.nvim_command("redrawstatus")
--     -- api.nvim_command("silent!mkview")
-- end, { expr = false })
