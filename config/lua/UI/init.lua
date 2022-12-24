
local api = vim.api

local ui_opts = {
    number         = true,
    cursorline     = true,
    title          = true,
    hlsearch       = true,
    incsearch      = true,
    list           = true,
    lazyredraw     = true,
    splitbelow     = true,
    splitright     = true,
    termguicolors  = true,
    wildmenu       = true,
    wrap           = false,
    modeline       = false,
    showmode       = false,
    ruler          = false,
    showcmd        = false,

    cmdheight     = 0,
    laststatus    = 3,
    numberwidth   = 4,
    pumwidth      = 5,
    scrolloff     = 6,
    sidescrolloff = 10,
    updatetime    = 20,
    pumheight     = 18,
    pumblend      = 25,
    winwidth      = 30,
    winblend      = 25,
    synmaxcol     = 140,
    redrawtime    = 100,

    -- colorcolumn  = "140",
    signcolumn   = "auto:1",
    shortmess    = "WAICOTFcsao",
    -- shortmess    = "filmnrwxaoOstTWAIcCqFS",

    -- titlestring  = "[   UNEXPECTED NVIM   ]",
    titlestring  = " nvim ",

    -- rulerformat = "[ %c  0𝙭%B ]",
    listchars = "eol:⸥,space:·,trail:,tab:,nbsp:n,extends:e,precedes:+",
}

for key, value in pairs(ui_opts) do
    -- can't use global?
    api.nvim_set_option_value(key, value, {})
end

require "UI.x-color" -- ~/.config/nvim/lua/UI/x-color.lua

require "UI.statusline"
require "UI.tabline"
require "UI.startup"

vim.defer_fn(function ()
    require "UI.fold"
    require "UI.visual-cnt"
    require "UI.search-cnt"
    require "UI.cmdline"
    -- require "UI.saved"
end, 200)

if vim.g.neovide == true then

    vim.o.listchars = "eol:⇂,space:･,trail:,tab:"
    vim.o.guifont = "Fixedsys Excelsior:h14.3:#x-subpixelantialias"
    vim.g.neovide_refresh_rate_idle       = 1
    vim.g.neovide_refresh_rate            = 360
    vim.g.neovide_transparency            = 0.9
    vim.g.neovide_cursor_animation_length = 0.02
    vim.g.neovide_scroll_animation_length = 0.07
    vim.g.neovide_cursor_trail_size       = 0.6

    vim.g.neovide_hide_mouse_when_typing  = true
    vim.g.neovide_cursor_antialiasing     = false
    vim.g.neovide_remember_window_size    = false
    vim.g.neovide_confirm_quit            = false
    vim.g.neovide_profiler                = false

    vim.g.neovide_cursor_vfx_particle_lifetime = 2
    vim.g.neovide_cursor_vfx_particle_density  = 5
    vim.g.neovide_cursor_vfx_particle_speed    = 20
    vim.g.neovide_cursor_vfx_opacity           = 100
    vim.g.neovide_cursor_vfx_mode = "torpedo"

    vim.g.neovide_floating_blur_amount_x = 0.6
    vim.g.neovide_floating_blur_amount_y = 0.6

    api.nvim_set_keymap("n", "<C-w>", "<CMD>q!<CR>", { noremap = true })

    require "UI.x-color".set_hl {
        CursorLine = { bg = "NONE" },

        TabLine  = { bg = "NONE", fg = "#404040" },
        TabLineP = { bg = "NONE", fg = "#C53B82" },
        TabLineX = { bg = "NONE", fg = "#C53B82" },

        ActiveTabSepL  = { bg = "NONE", fg = "#252525" },
        ActiveTabSepR  = { bg = "NONE", fg = "#252525" },
        ActiveFileIcon = { bg = "#252525", fg = "#9D7CD8" },
        ActiveTabName  = { bg = "#252525", fg = "#777777", italic = true },
        ActiveTabX     = { bg = "#252525", fg = "#707070" },
        ActiveTabMod   = { bg = "#252525", fg = "#AFC459" },

        InactiveTabSepL  = { bg = "NONE", fg = "#202020" },
        InactiveTabSepR  = { bg = "NONE", fg = "#202020" },
        InactiveFileIcon = { bg = "#202020", fg = "#404040" },
        InactiveTabName  = { bg = "#202020", fg = "#404040", italic = true },
        InactiveTabX     = { bg = "#202020", fg = "#404040" },
        InactiveTabMod   = { bg = "#202020", fg = "#404040" },
    }

end

