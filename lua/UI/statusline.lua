
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

-- function _G._GITSIGNS_STAUTS ()
--     -- local status = pcall(api.nvim_buf_get_var, { 0, "gitsigns_status" })
--     local status = vim.b.gitsigns_status or ""
--     if status ~= "" then
--         return "[ " .. status .. "%#statusLineL2# ] "
--     else
--         return ""
--     end
-- end

local L1 = "%#statusLineL1#%.100([ %Y ]%)"
-- M.L2 = "%#statusLineL2# %{% v:lua._GITSIGNS_STAUTS() %}"
local L2 = "%#statusLineL2# "
local L3 = "%#statusLineL3#[ %#statusLineL3#%F  %p%% ] "
local L4 = "%#statusLineL4#%{% &modified ? '%#statusLineR2#' : '%#statusLineL2#%r' %}"

-- •
local R1 = "%#statusLineR2#  %#statusLineR1#%{strftime('%H:%M %a')} %#statusLineR3# "
local R2 = "%#statusLine#%.20([ %c%#statusLineR2#  %#statusLine#0𝙭%B ]%) "
local R3 = "%#statusLineR3#%.40([ %l / %L ]%) "

vim.o.statusline = "%#statusLineL0#▎" .. L1 .. L2 .. L3 .. L4 .. "%=" .. R1 .. R2 .. R3
