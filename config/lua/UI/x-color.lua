
local M = {}

local api = vim.api

-- vim.keymap.set("n", ";;", "<CMD>so %<CR>")

local basic_hl = {
    FloatTitle   =  { bg = "NONE",    fg = "#AD475F" },
    VertSplit    =  { bg = "NONE",    fg = "#333333" },
    LineNr       =  { bg = "NONE",    fg = "#383838" },
    -- Search       =  { bg = "NONE",    fg = "#AE91E8" },
    -- IncSearch    =  { bg = "NONE",    fg = "#AE91E8" },
    Search       =  { bg = "NONE",    fg = "#D0EE7A" },
    IncSearch    =  { bg = "NONE",    fg = "#D0EE7A" },
    MatchParen   =  { bg = "NONE",    fg = "#C53B82" },
    Error        =  { bg = "NONE",    fg = "NONE" },

    Normal       =  { bg = "#232323", fg = "#707070"},
    CursorLine   =  { bg = "#252525", fg = "NONE" },
    PmenuSbar    =  { bg = "#383838", fg = "NONE" },
    PmenuThumb   =  { bg = "#505050", fg = "NONE" },
    Pmenu        =  { bg = "#282828", fg = "#757575" },
    PmenuSel     =  { bg = "#383838", fg = "#888888", bold = true },
    CursorLineNr =  { bg = "NONE",    fg = "#505050", bold = true },
    Visual       =  { bg = "NONE",    fg = "#9C8FDC", bold = true },
    ColorColumn  =  { bg = "#222222", fg = "NONE" },
    SignColumn   =  { bg = "NONE",    fg = "NONE" },
    NonText      =  { bg = "NONE",    fg = "#333333" },

    ErrorMsg     =  { bg = "NONE",    fg = "#666666" },

    StartTime       = { bg = "NONE",    fg = "#C53B82" },
}

local builtin_syntax_hl = {
    String      =  { bg = "NONE", fg = "#585858" },
    Comment     =  { bg = "NONE", fg = "#484848" },
    Number      =  { bg = "NONE", fg = "#555555" },
    Function    =  { bg = "NONE", fg = "#9C8FDC" },
    Statement   =  { bg = "NONE", fg = "#777777" },
    Constant    =  { bg = "NONE", fg = "#C53B82" },
    Luatable    =  { bg = "NONE", fg = "#777777" },
    Todo        =  { bg = "NONE", fg = "#FF9164" },
    Type        =  { bg = "NONE", fg = "#6a70ac" },
    Structure   =  { bg = "NONE", fg = "#7a70ac" },
    SpecialChar =  { bg = "NONE", fg = "#9C8FDC" },
}

local treesitter_hl = {
    ["@variable"]       = { bg = "NONE", fg = "#888888" }, -- var name
    ["@string"]         = { bg = "NONE", fg = "#585858" }, -- string
    ["@comment"]        = { bg = "NONE", fg = "#484848" }, -- comment
    ["@keyword"]        = { bg = "NONE", fg = "#777777" }, -- local return function
    ["@function"]       = { bg = "NONE", fg = "#9C8FDC", bold = true }, -- function
    ["@parameter"]      = { bg = "NONE", fg = "#9C8FDC" }, -- func args
    ["@number"]         = { bg = "NONE", fg = "#555555" }, -- number
    ["@constant"]       = { bg = "NONE", fg = "#C53B82" }, -- M.
    ["@boolean"]        = { bg = "NONE", fg = "#C53B82" }, -- true false
    ["@conditional"]    = { bg = "NONE", fg = "#9C8FDC" }, -- if then
    ["@repeat"]         = { bg = "NONE", fg = "#999999" }, -- for while
    ["@operator"]       = { bg = "NONE", fg = "#666666" }, -- =
    ["@punctuation"]    = { bg = "NONE", fg = "#444443" }, -- [] ,
    ["@constructor"]    = { bg = "NONE", fg = "#555555" }, -- { }
    ["@field"]          = { bg = "NONE", fg = "#666666" }, -- table key
    ["@method"]         = { bg = "NONE", fg = "#C53B82" }, -- :match :gsub

    ["@type"]           = { bg = "NONE", fg = "#555555" }, -- C: int float ..
    ["@property"]       = { bg = "NONE", fg = "#9D7CD8" }, -- C: ->xxx
    ["@include"]        = { bg = "NONE", fg = "#C3E88D" }, -- C: include

    ["@constant.builtin"]    = { bg = "NONE", fg = "#FF43BA" }, -- nil
    ["@function.builtin"]    = { bg = "NONE", fg = "#A7C080" }, -- print
    ["@type.definition"]     = { bg = "NONE", fg = "#9C8FDC" }, -- print
    ["@string.escape"]       = { bg = "NONE", fg = "#FF43BA" }, -- \n

    ["@keyword.return"]      = { bg = "NONE", fg = "#FF43BA" }, -- return
    ["@keyword.function"]    = { bg = "NONE", fg = "#FF43BA" }, -- function end
    ["@keyword.operator"]    = { bg = "NONE", fg = "#C53B82" }, -- and or not
}

local plugin_hl = {
    FloatTermNormal = { bg = "#232323", fg = "NONE" },
    CmdlinePrompt   = { bg = "NONE",    fg = "#C53B82" },
    CmdlineNormal   = { bg = "NONE",    fg = "#9C8FDC" },
    VisualCnt       = { bg = "NONE",    fg = "#444444" },
    SearchCnt       = { bg = "NONE",    fg = "#9C8FDC" },
}

function M.set_hl (tbl)
    for index, value in pairs(tbl) do
        api.nvim_set_hl(0, index, value)
    end

    return nil
end

M.set_hl(basic_hl)
-- M.set_hl(builtin_syntax_hl)
M.set_hl(treesitter_hl)

vim.defer_fn(function ()
    M.set_hl(plugin_hl)
end, 200)

return M
