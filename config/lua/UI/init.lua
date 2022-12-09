
local opt = vim.opt

local ui_opts = {
    number         = true,
    cursorline     = true,
    title          = true,
    hlsearch       = true,
    list           = true,
    lazyredraw     = true,
    splitbelow     = true,
    splitright     = true,
    termguicolors  = true,
    showmode       = false,
    ruler          = false,
    showcmd        = false,

    cmdheight     = 0,
    laststatus    = 3,
    numberwidth   = 4,
    pumwidth      = 5,
    scrolloff     = 6,
    sidescrolloff = 10,
    pumheight     = 18,
    pumblend      = 25,
    winwidth      = 30,
    winblend      = 25,
    synmaxcol     = 140,
    redrawtime    = 100,

    -- syntax       = "off",
    colorcolumn  = "140",
    signcolumn   = "auto:1",
    -- shortmess    = "WAICOTFcsao",
    shortmess    = "filmnrwxaoOstTWAIcCqFS",

    titlestring  = "[   UNEXPECTED NVIM   ]",

    -- rulerformat = "[ %c  0𝙭%B ]",
    listchars = "eol:⸥,space:·,trail:,tab:,multispace:····,nbsp:,extends:e,precedes:+",
}

for key, value in pairs(ui_opts) do
    opt[key] = value
end

require "UI.statusline"
require "UI.tabline"
require "UI.startup"
vim.defer_fn(function ()
    require "UI.visual-cnt"
    require "UI.search-cnt"
    require "UI.cmdline"
end, 200)

require "UI.x-color"
