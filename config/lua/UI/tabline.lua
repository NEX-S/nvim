
local fn  = vim.fn
local api = vim.api

require "UI.x-color".set_hl {

    TabLine  = { bg = "#111111", fg = "#ffffff" },
    TabLineP = { bg = "#111111", fg = "#C53B82" },
    TabLineN = { bg = "#111111", fg = "#424242" },
    TabLineX = { bg = "#111111", fg = "#C53B82" },

    ActiveTabSepL  = { bg = "#111111", fg = "#252525" },
    ActiveTabName  = { bg = "#252525", fg = "#777777", italic = true },
    ActiveTabX     = { bg = "#252525", fg = "#707070" },
    ActiveTabMod   = { bg = "#252525", fg = "#AFC459" },
    ActiveTabSepR  = { bg = "#111111", fg = "#252525" },
    ActiveFileIcon = { bg = "#252525", fg = "#9D7CD8" },

    InactiveTabSepL  = { bg = "#111111", fg = "#212121" },
    InactiveTabName  = { bg = "#202020", fg = "#444444", italic = true },
    InactiveTabX     = { bg = "#202020", fg = "#444444" },
    InactiveTabMod   = { bg = "#202020", fg = "#444444" },
    InactiveTabSepR  = { bg = "#111111", fg = "#212121" },
    InactiveFileIcon = { bg = "#202020", fg = "#444444" },
}

function _G._tabline_prefix ()
    api.nvim_command("tabnext")
end

function _G._tabline_create ()
    api.nvim_command("tabnew")
end

-- function _G._tabline_switch (tabnr)
--     api.nvim_command("tab " .. tabnr)
-- end

function _G._tabline_close (tabnr)
    if fn.tabpagenr("$") == 1 then
        api.nvim_command("quitall!")
    else
        api.nvim_command("tabclose!" .. tabnr)
    end
end

local function tab_ft_icon (tabnr, buflist)
    local ft_icons = {
        lua  = "  ",
    }

    local ft = api.nvim_buf_get_option(buflist[1], "filetype")

    return "%#InactiveFileIcon#" .. ( ft_icons[ft] or "  " )
end

local function tab_mod_status (tabnr, buflist)
    for i = 1, #buflist do
        if api.nvim_buf_get_option(buflist[i], "mod") == true then
            return  "%#InactiveTabMod#  "
        end
    end

    return "%#InactiveTabX#%" .. tabnr .. "@v:lua._tabline_close@  %X"
end

local function GenTabs(tabnr, active)
    local buflist   = fn.tabpagebuflist(tabnr)

    local tabicon   = tab_ft_icon   (tabnr, buflist)
    local modstatus = tab_mod_status(tabnr, buflist)

    local tabname   = api.nvim_buf_get_name(buflist[1])
    tabname = "%#InactiveTabName#" .. ( tabname ~= "" and tabname:gsub(".*/", "") or "UNKNOWN" )

    local res = "%#InactiveTabSepL#" .. tabicon .. tabname .. modstatus.. "%#InactiveTabSepR#"

    if active == true then
        res = res:gsub("Inactive", "Active")
        res = res:gsub("", "")
    end

    return "%" .. tabnr .. "T" .. res
end

function _G.NVIM_TABLINE ()
    local tabline = "%#TabLineP#%@v:lua._tabline_prefix@  "

    for tabnr = 1, fn.tabpagenr("$") do
        if tabnr == api.nvim_tabpage_get_number(0) then
            tabline = tabline .. GenTabs(tabnr, true)
        else
            tabline = tabline .. GenTabs(tabnr, false)
        end
    end

    local tabnew = "%#TabLineN#%@v:lua._tabline_create@+ %= %<"

    return tabline .. tabnew .. "%#TabLineX#%@v:lua._tabline_close@  "
end

api.nvim_set_option("showtabline", 2)
api.nvim_set_option("tabline",  "%!v:lua.NVIM_TABLINE()")

