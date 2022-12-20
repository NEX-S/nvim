local api = vim.api
local utils = require "utils"

vim.keymap.set("n", ";w", function ()
    vim.cmd "silent!write ++p"
    vim.cmd.redrawstatus()
    local saved_virt_ns_id = utils.set_virt_buf (0, "saved_virt_ns", "[ FILE SAVED ] ",
        { line = vim.fn.getpos("w0")[2], col = 0, pos = "right_align", hl_group = "SearchCnt" }
    )
    vim.defer_fn(function ()
        api.nvim_buf_del_extmark(0, saved_virt_ns_id, 1)
    end,500)
end)
