
local api = vim.api

local fn  = vim.fn

require "UI.x-color".set_hl {

    BufLine  = { bg = "#111111", fg = "#ffffff" },
    BufLineP = { bg = "#111111", fg = "#C53B82" },
    BufLineN = { bg = "#111111", fg = "#222222" },
    BufLineX = { bg = "#111111", fg = "#C53B82" },

    ActiveBufSepL = { bg = "#111111", fg = "#252525" },
    ActiveFTIcon  = { bg = "#252525", fg = "#777777" },
    ActiveBufName = { bg = "#252525", fg = "#777777", italic = true },
    ActiveBufX    = { bg = "#252525", fg = "#777777" },
    ActiveBufMod  = { bg = "#252525", fg = "#AFC460" },
    ActiveBufSepR = { bg = "#111111", fg = "#252525" },

    InactiveBufSepL = { bg = "#111111", fg = "#212121" },
    InactiveFTIcon  = { bg = "#202020", fg = "#444444" },
    InactiveBufName = { bg = "#202020", fg = "#444444", italic = true },
    InactiveBufX    = { bg = "#202020", fg = "#444444" },
    InactiveBufMod  = { bg = "#202020", fg = "#444444" },
    InactiveBufSepR = { bg = "#111111", fg = "#212121" },

    ActiveLuaIcon   = { bg = "#252525", fg = "#51A0CF" },
    InactiveLuaIcon = { bg = "#202020", fg = "#444444" },
}

function _G._bufline_prefix ()
    api.nvim_command("bn")
end

function _G._bufline_create ()
    api.nvim_command("tabnew")
end

function _G._bufline_switch (bufnr)
    api.nvim_command("buffer " .. bufnr)
end

function _G._bufline_close (bufnr)
    local bufcnt = 0

    for i = 1, fn.bufnr("$") do
        if fn.buflisted(i) == 1 then
            bufcnt = bufcnt + 1
        end
    end

    if bufcnt > 1 then
        local bufnr = bufnr or api.nvim_get_current_buf()
        pcall(api.nvim_command, "bd!" .. bufnr)
        api.nvim_command("redrawtabline")
    else
        api.nvim_command("quit!")
    end
end


local function buf_ft_icon (bufnr)

    local ft_icons = {
        lua  = "%#InactiveLuaIcon#  ",
    }

    local ft = api.nvim_buf_get_option(bufnr, "ft")

    return ft_icons[ft] or "%#InactiveBufName#  "
end

local function buf_mod_status (bufnr)
    local bufmod   = "%#InactiveBufMod#  "
    local bufclose = "%#InactiveBufX#%" .. bufnr .. "@v:lua._G._bufline_close@  %X"
    return api.nvim_buf_get_option(bufnr, "mod") and bufmod or bufclose
end

local function GenTabs(bufnr, active)

    local buficon   = buf_ft_icon(bufnr)
    local bufname   = api.nvim_buf_get_name(bufnr)

    local modstatus = buf_mod_status(bufnr)

    bufname = "%#InactiveBufName#" .. ( bufname ~= "" and bufname:gsub(".*/", "") or "UNKNOWN" )

    local ret = "%#InactiveBufSepL#" .. buficon .. bufname .. modstatus.. "%#InactiveBufSepR#"

    if active == true then
        ret = ret:gsub("Inactive", "Active")
    end

    return "%" .. bufnr .. "@v:lua._bufline_switch@" .. ret
end

function _G.NVIM_BUFLINE ()

    local bufline = "%#BufLineP#%@v:lua._bufline_prefix@  "
    local current = api.nvim_get_current_buf()

    for bufnr = 1, fn.bufnr("$") do
        if fn.buflisted(bufnr) == 1 then
            if bufnr == current then
                bufline = bufline .. GenTabs(bufnr, true)
            else
                bufline = bufline .. GenTabs(bufnr, false)
            end
        end
    end

    local bufnew   = "%#BufLineN#%@v:lua._bufline_create@+ %= %<"
    local bufclose = "%#BufLineX#%" .. current .. "@v:lua._bufline_close@  "

    return bufline .. bufnew .. bufclose
end

api.nvim_set_option("showtabline", 2)
api.nvim_set_option("tabline",  "%!v:lua.NVIM_BUFLINE()")
