
local api = vim.api
local opt = vim.opt

opt.showtabline = 2

function _G.get_ft_icon ()
    local ft_icons = {
        lua = "%#LuaIcon# ",
    }
    return ft_icons[vim.bo.ft] or ""
end

local FileTypeIconHL = {
    LuaIcon = { bg = "#262626", fg = "#51a0cf" },
}

for key, value in pairs(FileTypeIconHL) do
    api.nvim_set_hl(0, key, value)
end

local TabLineHL = {

    TabLine   = { bg = "#191919", fg = "#666666" },
    TabLineP  = { bg = "#191919", fg = "#C53B82" },
    TabLineX  = { bg = "#191919", fg = "#C53B82" },

    InactiveTab     = { bg = "#202020", fg = "#444444" },
    InactiveTabX    = { bg = "#202020", fg = "#444444" },
    InactiveTabMod  = { bg = "#202020", fg = "#444444" },

    InactiveTabSepL  = { bg = "#191919", fg = "#202020" },
    InactiveTabSepR  = { bg = "#191919", fg = "#202020" },

    ActiveTab      = { bg = "#242424", fg = "#777777" },
    ActiveTabX     = { bg = "#242424", fg = "#777777" },
    ActiveTabMod   = { bg = "#242424", fg = "#AFC460" },

    ActiveTabSepL  = { bg = "#191919", fg = "#242424" },
    ActiveTabSepR  = { bg = "#191919", fg = "#242424" },
}

for key, value in pairs(TabLineHL) do
    api.nvim_set_hl(0, key, value)
end


local fn = vim.fn
local function GenInactiveTab (tabnr)
    local tabwinnr   = fn.tabpagewinnr(tabnr)
    local tabbuflist = fn.tabpagebuflist(tabnr)
    local tabname    = api.nvim_buf_get_name(tabbuflist[tabwinnr]):gsub(".*/", '')

    -- local InactiveTabIndicator = "%{% &mod ? '%#InactiveTabMod# ' : '%#InactiveTabX# ' %}"
    local InactiveTabContent = "%#InactiveTab#  %" .. tabnr .. "T" .. tabname .. "%#InactiveTabX# %1X%X"
    -- return "%#InactiveTabSepL#" .. InactiveTabContent .. " %#InactiveTabSepR#"
    return "%#InactiveTabSepL#" .. InactiveTabContent .. " %#InactiveTabSepR#"
end

local function GenActiveTab ()
    local ActiveTabFileName  = api.nvim_buf_get_name(0)
    local ActiveTabIndicator = "%{% &mod ? '%#ActiveTabMod# ' : '%#ActiveTabX# %1X%X' %}"

    ActiveTabFileName = ActiveTabFileName == "" and "[  UNKNOWN  ]" or ActiveTabFileName:gsub(".*/", '') .. ActiveTabIndicator

    local ActiveTabContent   = "%#ActiveTab# %{% v:lua.get_ft_icon() %}%#ActiveTab#" .. ActiveTabFileName

    -- return "%#ActiveTabSepL# " .. ActiveTabContent .. " %#ActiveTabSepR#"
    return "%#ActiveTabSepL#" .. ActiveTabContent .. " %#ActiveTabSepR#"
end


function _G.nvim_tabline ()

    local tabLine = "%#TabLineP#  "

    local tabtotal = fn.tabpagenr("$")

    if tabtotal == 1 then
        tabLine = tabLine .. GenActiveTab()
    else
        for i = 1, tabtotal do
            if i == api.nvim_tabpage_get_number(0) then
                tabLine = tabLine .. GenActiveTab()
            else
                tabLine = tabLine .. GenInactiveTab(i)
            end
        end
    end

    return tabLine .. "%T %#TabLine# %= %#TabLineX# %1X%X "
end


opt.tabline = "%!v:lua.nvim_tabline()"

-- /etc/passwd
-- ~/.config/nvim/init.lua
-- ~/.config/nvim/colors.md
-- ~/.config/nvim/api.md

