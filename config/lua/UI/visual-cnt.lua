
local api = vim.api

local utils = require "utils"

api.nvim_create_autocmd("ModeChanged", {
    pattern = { "n:v", "n:V" },
    callback = function ()

        local line_len = #api.nvim_get_current_line():gsub("^%s*", '') + 1

        local line = api.nvim_win_get_cursor(0)[1]
        local bufnr = api.nvim_get_current_buf()

        local ns_id = nil
        if api.nvim_get_mode().mode == "V" then
            ns_id = utils.set_virt_buf(bufnr, "visual_cnt", " [ " .. line_len .. " / " .. line_len .. " ]", {
                col = 0,
                line = line - 1,
                hl_group = "VisualCnt",
                pos = "eol",
            })
            -- return
        else
            ns_id = utils.set_virt_buf(bufnr, "visual_cnt", " [ 1 / " .. line_len .. " ]", {
                col = 0,
                line = line - 1,
                hl_group = "VisualCnt",
                pos = "eol",
            })
        end

        -- local au_id = api.nvim_create_augroup("VisualCntAutocmdGroup", { clear = true })
        local au_id = api.nvim_create_autocmd("CursorMoved", {
            pattern = "*",
            callback = function ()
                api.nvim_buf_del_extmark(bufnr, ns_id, 1)
                local cursor_pos = api.nvim_win_get_cursor(0)

                if cursor_pos[1] == line then
                    local visual_start = vim.fn.getpos("v")[3]
                    local visual_end   = cursor_pos[2] + 1

                    if visual_start > visual_end then
                        visual_start, visual_end = visual_end, visual_start
                    end

                    local char_cnt = visual_end - visual_start + 1

                    utils.set_virt_buf(bufnr, "visual_cnt", " [ " .. char_cnt .. " / " .. line_len .. " ]", {
                        col = 0,
                        line = line - 1,
                        hl_group = "VisualCnt",
                        pos = "eol",
                    })
                else
                    -- [[ 不想写跨行的情况 ]]
                end
            end
        })

        api.nvim_create_autocmd("ModeChanged", {
            pattern = "v:n",
            once = true,
            callback = function ()
                api.nvim_buf_del_extmark(bufnr, ns_id, 1)
                api.nvim_del_autocmd(au_id)
                -- api.nvim_del_augroup_by_name("VisualCntAutocmdGroup")
            end
        })

    end
})

