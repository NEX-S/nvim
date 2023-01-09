
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
    breakindent    = true,
    wrap           = false,
    modeline       = false,
    showmode       = false,
    ruler          = false,
    showcmd        = false,

    cmdheight     = 0,
    laststatus    = 3,
    numberwidth   = 1,
    pumwidth      = 5,
    scrolloff     = 6,
    sidescrolloff = 10,
    updatetime    = 30,
    pumheight     = 18,
    pumblend      = 25,
    winwidth      = 30,
    winblend      = 25,
    synmaxcol     = 140,
    redrawtime    = 100,

    -- colorcolumn  = "140",
    splitkeep    = "screen", -- topline?
    signcolumn   = "yes:1",
    shortmess    = "WAICOTFcsao",
    -- shortmess    = "filmnrwxaoOstTWAIcCqFS",

    -- titlestring  = "[   UNEXPECTED NVIM   ]",
    -- titlestring  = " nvim ",

    -- rulerformat = "[ %c  0𝙭%B ]",
    -- ⨯
    fillchars = "vert:⎹,vertleft:⎹,vertright:⎹,horiz:⸻,horizup:⸻,horizdown:⸻,fold: ,eob:,msgsep:",
    listchars = "eol:⸥,space:·,trail:,tab:,nbsp:n,extends:e,precedes:+",
}

for key, value in pairs(ui_opts) do
	api.nvim_set_option_value(key, value, {})
end

require "UI.x-color" -- ~/nvim/lua/UI/x-color.lua

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
    vim.g.neovide_transparency            = 0.98
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

    -- vim.g.neovide_padding_top    = 5
    -- vim.g.neovide_padding_left   = 0
    -- vim.g.neovide_padding_right  = 0
    -- vim.g.neovide_padding_bottom = 0

    -- api.nvim_set_keymap("n", "<C-w>", "<CMD>quit!<CR>", { noremap = true })

    -- vim.keymap.set("n", ";d", function ()
    --     -- for i = 1, fn.bufnr("$") do
    --     --     if fn.buflisted(i) == 1 and api.nvim_buf_get_name(0) ~= "" then
    --     --         bufcnt = bufcnt + 1
    --     --         break
    --     --         return "<CMD>quit!<CR>"
    --     --     end
    --     -- end
    --     -- if bufcnt == 1 then
    --     --
    --     -- end
    --     if fn.tabpagenr("$") == 1 then
    --         -- fn.termopen("vifm")
    --         -- api.nvim_command("startinsert!")
    --         -- api.nvim_command("redraw!")
    --         api.nvim_command("e term://vifm")
    --         api.nvim_command("startinsert!")
    --         api.nvim_set_option_value("number", false, {})
    --     else
    --         api.nvim_command("quit!")
    --     end
    --     -- return "<CMD>F<CR>"
    -- end, { expr = false })
end
