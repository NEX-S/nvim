
local api = vim.api
local opt = vim.opt

opt.showtabline = 2

function _G.get_ft_icon (status)
    local ft_icons_a = {
        lua = "%#LuaIconA# %#ActiveTab#",
    }
    local ft_icons_i = {
        lua = "%#LuaIconI# %#InactiveTab#",
    }

    local ft = vim.bo.ft
    return status == "a" and ft_icons_a[ft] or ft_icons_i[ft] or " "
end

local FileTypeIconHL = {
    LuaIconA = { bg = "#232323", fg = "#51a0cf" },
    LuaIconI = { bg = "#202020", fg = "#333333" },
}

for key, value in pairs(FileTypeIconHL) do
    api.nvim_set_hl(0, key, value)
end

local fn = vim.fn
local function GenInactiveTab (tabnr)
    local tabwinnr   = fn.tabpagewinnr(tabnr)
    local tabbuflist = fn.tabpagebuflist(tabnr)
    local tabname    = api.nvim_buf_get_name(tabbuflist[tabwinnr]):gsub(".*/", '')

    local InactiveTabName = tabname == "" and "UNKNOWN " or tabname:gsub(".*/", '') .. "%#InactiveTabX# %1X%X"

    -- local InactiveTabIndicator = "%{% &mod ? '%#InactiveTabMod# ' : '%#InactiveTabX# ' %}"
    local InactiveTabContent = "%#InactiveTab# %" .. tabnr .. "T" .. "%{% v:lua.get_ft_icon('i') %}" .. InactiveTabName
    -- return "%#InactiveTabSepL#" .. InactiveTabContent .. " %#InactiveTabSepR#"
    return "%#InactiveTabSepL#" .. InactiveTabContent .. " %#InactiveTabSepR#"
end

local function GenActiveTab ()
    local ActiveTabFileName  = api.nvim_buf_get_name(0)
    local ActiveTabIndicator = "%{% &mod ? '%#ActiveTabMod# ' : '%#ActiveTabX# %1X%X' %}"

    ActiveTabFileName = ActiveTabFileName == "" and "[ UNKNOWN ] " or ActiveTabFileName:gsub(".*/", '') .. ActiveTabIndicator

    local ActiveTabContent   = "%#ActiveTab# %{% v:lua.get_ft_icon('a') %}" .. ActiveTabFileName

    -- return "%#ActiveTabSepL# " .. ActiveTabContent .. " %#ActiveTabSepR#"
    return "%#ActiveTabSepL#" .. ActiveTabContent .. " %#ActiveTabSepR#"
end


function _G.nvim_tabline ()

    local tabLine = "%#TabLineP#%3@v:lua._nvim_tabline_prefix@  "

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

    -- return tabLine .. "%T %#TabLine# %= %#TabLineX# %1X%X "
    return tabLine .. "%T %#TabLine# %= %#TabLineX#%3@v:lua._nvim_tabline_close@  %X"
end

function _G._nvim_tabline_prefix ()
    vim.cmd "tabnew"
end

function _G._nvim_tabline_close ()
    if fn.tabpagenr("$") == 1 then
        -- vim.cmd "quitall!"
        -- vim.cmd "quitall!"
        os.execute("kitty @ --to unix:/tmp/kitty.sock close-tab")
    else
        vim.cmd "tabclose"
    end
end

opt.tabline = "%!v:lua.nvim_tabline()"

-- /etc/passwd
-- ~/.config/nvim/init.lua
-- ~/.config/nvim/colors.md
-- ~/.config/nvim/api.md

local TabLineHL = {

    TabLine   = { bg = "#242424", fg = "#666666" },
    TabLineP  = { bg = "#242424", fg = "#C53B82" },
    TabLineX  = { bg = "#242424", fg = "#C53B82" },
    
    InactiveTab     = { bg = "#202020", fg = "#444444" },
    InactiveTabX    = { bg = "#202020", fg = "#444444" },
    InactiveTabMod  = { bg = "#202020", fg = "#444444" },
    
    InactiveTabSepL  = { bg = "#242424", fg = "#202020" },
    InactiveTabSepR  = { bg = "#242424", fg = "#202020" },
    
    ActiveTab      = { bg = "#232323", fg = "#777777" },
    ActiveTabX     = { bg = "#232323", fg = "#777777" },
    ActiveTabMod   = { bg = "#232323", fg = "#AFC460" },
    
    ActiveTabSepL  = { bg = "#242424", fg = "#232323" },
    ActiveTabSepR  = { bg = "#242424", fg = "#232323" },
}

for key, value in pairs(TabLineHL) do
    api.nvim_set_hl(0, key, value)
end

