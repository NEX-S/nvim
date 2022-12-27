
local api = vim.api

local L1 = "%#statusLineL1#[ %Y ] "
local L2 = "%#statusLineL2#[ %#statusLineL2#%F  %p%% ] "
local L3 = "%#statusLineL3#%{% &modified ? '%#statusLineR2#' : '%#statusLineL2#%r' %}"

local R1 = "%#statusLineR2# %#statusLineR1#%{strftime('%H:%M %a')} %#statusLineR3#• "
local R2 = "%#statusLine#[ %c%#statusLineR2#  %#statusLine#0𝙭%B ] "
local R3 = "%#statusLineR3#[ %l / %L ] "

vim.opt.statusline = "%#statusLineL0#▎" .. L1 .. L2 .. L3 .. "%=" .. R1 .. R2 .. R3

require "UI.x-color".set_hl {
    statusLine = { bg = "NONE", fg = "#585858" },

    statusLineL0 = { bg = "NONE", fg = "#333333" },
    statusLineL1 = { bg = "NONE", fg = "#C53B82" },
    statusLineL2 = { bg = "NONE", fg = "#444444" },
    statusLineL3 = { bg = "NONE", fg = "#444444" },

    statusLineR1 = { bg = "NONE", fg = "#444444" },
    statusLineR2 = { bg = "NONE", fg = "#555555" },
    statusLineR2 = { bg = "NONE", fg = "#AFC460" },
    statusLineR3 = { bg = "NONE", fg = "#C53B82" },
}
