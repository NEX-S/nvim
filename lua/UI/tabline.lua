
local fn  = vim.fn
local api = vim.api


require "UI.x-color".set_hl {
    TabLine  = { bg = "#191919", fg = "#252525" },
    TabLineT = { bg = "#191919", fg = "#252525", italic = true },
    TabLineP = { bg = "#191919", fg = "#C53B82" },
    TabLineX = { bg = "#191919", fg = "#C53B82" },

    ActiveTabSepL  = { bg = "#191919", fg = "#252525" },
    ActiveTabSepR  = { bg = "#191919", fg = "#252525" },
    ActiveFileIcon = { bg = "#252525", fg = "#9D7CD8" },
    ActiveTabName  = { bg = "#252525", fg = "#777777", italic = true },
    ActiveTabX     = { bg = "#252525", fg = "#707070" },
    ActiveTabMod   = { bg = "#252525", fg = "#AFC459" },

    InactiveTabSepL  = { bg = "#191919", fg = "#202020" },
    InactiveTabSepR  = { bg = "#191919", fg = "#202020" },
    InactiveFileIcon = { bg = "#202020", fg = "#404040" },
    InactiveTabName  = { bg = "#202020", fg = "#404040", italic = true },
    InactiveTabX     = { bg = "#202020", fg = "#404040" },
    InactiveTabMod   = { bg = "#202020", fg = "#404040" },
}

function _G._tabline_prefix ()
    api.nvim_command("tabnext")
end

function _G._tabline_create ()
    api.nvim_command("tabnew")
end

function _G._tabline_close (tabnr)
    if fn.tabpagenr("$") == 1 then
        api.nvim_command("quitall!")
    else
        api.nvim_command("tabclose!" .. tabnr)
    end
end

-- vim.b.gitsigns_status = ""
-- api.nvim_buf_set_var(0, "gitsigns_status", "")
function _G._GITSIGNS_TABLINE ()
    -- local tabnr = api.nvim_tabpage_get_number(0)
    -- local buflist = fn.tabpagebuflist(tabnr)
    --
    -- local status = nil
    -- for i = 1, #buflist do
    --     -- status = api.nvim_buf_get_var(buflist[i], "gitsigns_status")
    --     if status ~= "" then
    --         return status
    --     end
    -- end
    --
    -- return ""

    local status = vim.b.gitsigns_status

    return status and status or ""
end

local function tab_ft_icon (tabnr, buflist)
    local icons = {
        lua  = "  ",
        vim  = "  ",
        markdown = "  ",
        html = "  ",
        c    = "  "
    }

    local ft = api.nvim_buf_get_option(buflist[1], "filetype")

    return "%#InactiveFileIcon#" .. ( icons[ft] or "  " )
end

local function tab_mod_status (tabnr, buflist)
    for i = 1, #buflist do
        if api.nvim_buf_get_option(buflist[i], "mod") == true then
            return  "%#InactiveTabMod# "
        end
    end

    -- return "%#InactiveTabX#%" .. tabnr .. "@v:lua._tabline_close@ %X"
    return "%#InactiveTabX#%" .. tabnr .. "X %X"
end

local function GenTabs(tabnr, active)
    local buflist   = fn.tabpagebuflist(tabnr)

    local tabicon   = tab_ft_icon   (tabnr, buflist)
    local modstatus = tab_mod_status(tabnr, buflist)

    local tabname   = api.nvim_buf_get_name(buflist[1]) .. " "
    tabname = "%#InactiveTabName#" .. ( tabname ~= " " and tabname:gsub(".*/", "") or "UNKNOWN " )

    local res = "%#InactiveTabSepL#" .. tabicon .. tabname .. modstatus.. "%#InactiveTabSepR#"

    res = active ~= true and res or res:gsub("Inactive", "Active"):gsub("", "", 1)

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

    local tabnew = "%#TabLine#%@v:lua._tabline_create@+ %T %= %<"

    -- return tabline .. tabnew .. "%{% v:lua._GITSIGNS_TABLINE() %} %#TabLineX#%@v:lua._tabline_close@  "
    return tabline .. tabnew .. "%#TabLineT#%{strftime('%H:%M %a')}%#TabLineX#%@v:lua._tabline_close@  "
end

api.nvim_set_option("showtabline", 2)
api.nvim_set_option("tabline",  "%!v:lua.NVIM_TABLINE()")


local timer = vim.loop.new_timer()
timer:start(60000, 1, vim.schedule_wrap (
    function()
        api.nvim_command("redrawtabline")
    end)
)
