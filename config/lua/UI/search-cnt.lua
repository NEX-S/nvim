
local api = vim.api

local utils = require "utils"

_G.search_virt_ns_id = nil
local function search_cnt_virt (offset)

    local offset = offset or 0
    local search_info = vim.fn.searchcount {
        recompute = true, maxcount = 1000, timeout = 100
    }

    if search_info.current == nil then
        return
    end

    local total   = search_info.total
    local current = search_info.current + 0
    local incomplete = search_info.incomplete

    if total ~= 0 and incomplete == 0 then
        local search_virt = "[ " .. current + offset .. " / " .. total .. " ] "

        _G.search_virt_ns_id = utils.set_virt_buf (0, "search_count_ns", search_virt,
            { line = vim.fn.getpos("w0")[2], col = 0, pos = "right_align", hl_group = "SearchCnt" }
        )
    elseif total == 0 and incomplete == 0 then
        _G.search_virt_ns_id = utils.set_virt_buf (0, "search_count_ns", "[ 0 / 0 ] ",
            { line = vim.fn.getpos("w0")[2], col = 0, pos = "right_align", hl_group = "SearchCnt" }
        )
    elseif total ~= 0 and incomplete == 2 then
        _G.search_virt_ns_id = utils.set_virt_buf (0, "search_count_ns", "[" .. current .. " / MAX ] ",
            { line = vim.fn.getpos("w0")[2], col = 0, pos = "right_align", hl_group = "SearchCnt" }
        )
    end
end

local search_keymap = {
    ["<ESC>"] = function ()
        api.nvim_command "set hls!"
        if _G.search_virt_ns_id ~= nil then
            api.nvim_buf_del_extmark(0, _G.search_virt_ns_id, 1)
        end
    end,
    ["n"] = function ()
        pcall(api.nvim_command, "normal!n")
        search_cnt_virt()
    end,
    ["N"] = function ()
        pcall(api.nvim_command, "normal!N")
        search_cnt_virt()
    end,
}

for lhs, rhs in pairs(search_keymap) do
    vim.keymap.set("n", lhs, rhs, { expr = false })
end

vim.keymap.set("n", ";f", function ()
    search_cnt_virt(1)
    return "/"
end, { expr = true })
