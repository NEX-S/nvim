
local M = {}

local api = vim.api

local basic_hl = {
    FloatTitle   =  { bg = "NONE",    fg = "#AD475F" },
    VertSplit    =  { bg = "NONE",    fg = "#333333" },
    LineNr       =  { bg = "NONE",    fg = "#383838" },
    Search       =  { bg = "NONE",    fg = "#D0EE7A" },
    IncSearch    =  { bg = "NONE",    fg = "#D0EE7A" },
    MatchParen   =  { bg = "NONE",    fg = "#C53B82" },
    Error        =  { bg = "NONE",     },
    QuickFixLine =  { bg = "#252525", fg = "#FF43BA" },

    Normal       =  { bg = "#232323",    fg = "#707070"},
    CursorLine   =  { bg = "#252525",     },
    PmenuSbar    =  { bg = "#383838",     },
    PmenuThumb   =  { bg = "#505050",     },
    Pmenu        =  { bg = "#282828",    fg = "#757575" },
    PmenuSel     =  { bg = "#383838",    fg = "#888888", bold = false },
    CursorLineNr =  { bg = "NONE",    fg = "#505050", bold = false },
    Visual       =  { bg = "NONE",    fg = "#9C8FDC", bold = false },
    ColorColumn  =  { bg = "#222222",     },
    SignColumn   =  { bg = "NONE",     },
    NonText      =  { bg = "NONE",    fg = "#353535" },
    EndOfBuffer  =  { bg = "NONE",    fg = "#303030" },

    ErrorMsg     =  { bg = "NONE",    fg = "#666666" },

    StartTime    =  { bg = "NONE",     fg = "#C53B82" },

    Folded       =  { bg = "NONE",     fg = "#BB9AF7", bold = false },
    FoldColumn   =  { bg = "NONE",     fg = "#BB9AF7", bold = false },
}

-- local builtin_syntax_hl = {
--     String      =  { bg = "NONE", fg = "#585858" },
--     Comment     =  { bg = "NONE", fg = "#484848" },
--     Number      =  { bg = "NONE", fg = "#555555" },
--     Function    =  { bg = "NONE", fg = "#9C8FDC" },
--     Statement   =  { bg = "NONE", fg = "#777777" },
--     Constant    =  { bg = "NONE", fg = "#C53B82" },
--     Luatable    =  { bg = "NONE", fg = "#777777" },
--     Todo        =  { bg = "NONE", fg = "#FF9164" },
--     Type        =  { bg = "NONE", fg = "#6a70ac" },
--     Structure   =  { bg = "NONE", fg = "#7a70ac" },
--     SpecialChar =  { bg = "NONE", fg = "#9C8FDC" },
-- }

local plugin_hl = {
    FloatTermNormal = { bg = "#232323" },
    CmdlinePrompt   = { bg = "NONE",    fg = "#C48B82" },
    CmdlineNormal   = { bg = "#202020",    fg = "#9C8FDC" },
    VisualCnt       = { bg = "NONE",    fg = "#444444" },
    SearchCnt       = { bg = "NONE",    fg = "#9C8FDC" },
    TranslateVirt   = { bg = "NONE",    fg = "#383838", italic = false },

    LazyNormal = { bg = "#232323", fg = "#666666" },
    LazyHandlerSource = { bg = "NONE", fg = "#444444" },
    LazyHandlerPlugin = { bg = "NONE", fg = "#C53B82" },
    LazyMuted = { bg = "NONE", fg = "#444444" },
}

function M.set_hl (tbl)
    for group, value in pairs(tbl) do
        api.nvim_set_hl(0, group, value)
    end

    -- return nil
end

M.set_hl(basic_hl)

-- M.set_hl(builtin_syntax_hl)

vim.defer_fn(function ()
    M.set_hl(plugin_hl)
end, 200)

return M
