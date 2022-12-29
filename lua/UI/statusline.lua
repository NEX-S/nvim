
local api = vim.api

require "UI.x-color".set_hl {
    statusLine = { bg = "NONE", fg = "#585858" },

    statusLineL0 = { bg = "NONE", fg = "#404040" },
    statusLineL1 = { bg = "NONE", fg = "#C53B82" },
    statusLineL2 = { bg = "NONE", fg = "#444444" },
    statusLineL3 = { bg = "NONE", fg = "#444444" },
    statusLineL4 = { bg = "NONE", fg = "#444444" },

    statusLineR1 = { bg = "NONE", fg = "#444444" },
    statusLineR2 = { bg = "NONE", fg = "#555555" },
    statusLineR2 = { bg = "NONE", fg = "#AFC460" },
    statusLineR3 = { bg = "NONE", fg = "#C53B82" },
}

local M = {}

function _G._GITSIGNS_STAUTS ()
    -- local status = pcall(api.nvim_buf_get_var, { 0, "gitsigns_status" })
    local status = vim.b.gitsigns_status or ""
    if status ~= "" then
        return "[ " .. status .. "%#statusLineL2# ] "
    else
        return ""
    end
end

M.L1 = "%#statusLineL1#%.100([ %Y ]%)"
M.L2 = "%#statusLineL2# %{% v:lua._GITSIGNS_STAUTS() %}"
M.L3 = "%#statusLineL3#[ %#statusLineL3#%F  %p%% ] "
M.L4 = "%#statusLineL4#%{% &modified ? '%#statusLineR2#' : '%#statusLineL2#%r' %}"

M.R1 = "%#statusLineR2#  %#statusLineR1#%{strftime('%H:%M %a')} %#statusLineR3#• "
M.R2 = "%#statusLine#%.20([ %c%#statusLineR2#  %#statusLine#0𝙭%B ]%) "
M.R3 = "%#statusLineR3#%.40([ %l / %L ]%) "

vim.o.statusline = "%#statusLineL0#▎" .. M.L1 .. M.L2 .. M.L3 .. M.L4 .. "%=" .. M.R1 .. M.R2 .. M.R3

return M
