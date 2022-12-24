
local M = {}

local api = vim.api

local basic_hl = {
    FloatTitle   =  { bg = "#232323",    fg = "#AD475F" },
    VertSplit    =  { bg = "#232323",    fg = "#333333" },
    LineNr       =  { bg = "#232323",    fg = "#383838" },
    Search       =  { bg = "#232323",    fg = "#D0EE7A" },
    IncSearch    =  { bg = "#232323",    fg = "#D0EE7A" },
    MatchParen   =  { bg = "#232323",    fg = "#C53B82" },
    Error        =  { bg = "#232323",     },

    Normal       =  { bg = "#232323",    fg = "#707070"},
    CursorLine   =  { bg = "#252525",     },
    PmenuSbar    =  { bg = "#383838",     },
    PmenuThumb   =  { bg = "#505050",     },
    Pmenu        =  { bg = "#282828",    fg = "#757575" },
    PmenuSel     =  { bg = "#383838",    fg = "#888888", bold = false },
    CursorLineNr =  { bg = "#232323",    fg = "#505050", bold = false },
    Visual       =  { bg = "#232323",    fg = "#9C8FDC", bold = false },
    ColorColumn  =  { bg = "#222222",     },
    SignColumn   =  { bg = "#232323",     },
    NonText      =  { bg = "#232323",    fg = "#333333" },

    ErrorMsg     =  { bg = "#232323",    fg = "#666666" },

    StartTime    =  { bg = "#232323",     fg = "#C53B82" },

    Folded       =  { bg = "#252525",     fg = "#BB9AF7", bold = false },
}

-- local builtin_syntax_hl = {
--     String      =  { bg = "#232323", fg = "#585858" },
--     Comment     =  { bg = "#232323", fg = "#484848" },
--     Number      =  { bg = "#232323", fg = "#555555" },
--     Function    =  { bg = "#232323", fg = "#9C8FDC" },
--     Statement   =  { bg = "#232323", fg = "#777777" },
--     Constant    =  { bg = "#232323", fg = "#C53B82" },
--     Luatable    =  { bg = "#232323", fg = "#777777" },
--     Todo        =  { bg = "#232323", fg = "#FF9164" },
--     Type        =  { bg = "#232323", fg = "#6a70ac" },
--     Structure   =  { bg = "#232323", fg = "#7a70ac" },
--     SpecialChar =  { bg = "#232323", fg = "#9C8FDC" },
-- }

local plugin_hl = {
    FloatTermNormal = { bg = "#232323" },
    CmdlinePrompt   = { bg = "#232323",    fg = "#C53B82" },
    CmdlineNormal   = { bg = "#232323",    fg = "#9C8FDC" },
    VisualCnt       = { bg = "#232323",    fg = "#444444" },
    SearchCnt       = { bg = "#232323",    fg = "#9C8FDC" },
}

function M.set_hl (tbl)
    for group, value in pairs(tbl) do
        api.nvim_set_hl(0, group, value)
    end

    -- return nil
end

M.set_hl(basic_hl)

-- M.set_hl(builtin_syntax_hl)

-- vim.defer_fn(function ()
--     M.set_hl(plugin_hl)
-- end, 200)

return M
