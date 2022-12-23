
local fn  = vim.fn

local api = vim.api
local opt = vim.o

opt.showtabline = 2

function _G.get_ft_icon (status, tabnr)
    local ft_icons_a = {
        lua  = "%#LuaIconA#  %#ActiveTab#",
        terminal = "%#LuaIconA# T %#ActiveTab#",
    }
    local ft_icons_i = {
        lua = "%#LuaIconI#  %#InactiveTab#",
        terminal = "%#LuaIconI# T %#InactiveTab#",
    }

    local ft = nil
    if fn.tabpagenr("$") == 1 then
        ft = vim.bo.ft
    else
        --  TODO: get tab icon is so fuctking hard :O
        local bufnr_list = vim.fn.tabpagebuflist(tabnr)

        for i = 1, #bufnr_list do
            ft = vim.fn.getbufvar(bufnr_list[i], "&ft")
        end
    end


    return status == "a" and (ft_icons_a[ft] or "") or (ft_icons_i[ft] or "") or "  "
end

local FileTypeIconHL = {
    LuaIconA = { bg = "#232323", fg = "#51a0cf" },
    LuaIconI = { bg = "#202020", fg = "#333333" },
}

for key, value in pairs(FileTypeIconHL) do
    api.nvim_set_hl(0, key, value)
end

local function GenInactiveTab (tabnr)
    local tabwinnr   = fn.tabpagewinnr(tabnr)
    local tabbuflist = fn.tabpagebuflist(tabnr)
    local tabname    = api.nvim_buf_get_name(tabbuflist[tabwinnr]):gsub(".*/", '')

    local InactiveTabIndicator = "%{% v:lua._tabline_get_mod_status(" .. tabnr .. ") == 1 ? '%#InactiveTabMod# ' : '%#InactiveTabX# %" .. tabnr .."X%X' %}"
    -- local InactiveTabName = tabname == "" and "UNKNOWN " or tabname:gsub(".*/", '') .. "%#InactiveTabX# %" .. tabnr .. "X%X"
    local InactiveTabName = (tabname == "" and "  [ UNKNOWN ] " or _G.get_ft_icon("i", tabnr) .. tabname:gsub(".*/", '') .. InactiveTabIndicator)

    local InactiveTabContent = "%#InactiveTab#%" .. tabnr .. "T" .. InactiveTabName
    -- return "%#InactiveTabSepL#" .. InactiveTabContent .. " %#InactiveTabSepR#"
    return "%#InactiveTabSepL#" .. InactiveTabContent .. " %#InactiveTabSepR#"
end

local function GenActiveTab (tabnr)
    local ActiveTabFileName  = api.nvim_buf_get_name(0)
    local ActiveTabIndicator = "%{% v:lua._tabline_get_mod_status(" .. tabnr .. ") == 1 ? '%#ActiveTabMod# ' : '%#ActiveTabX# %1@v:lua._nvim_tabline_close@𝘹%X' %}"

    ActiveTabFileName = ActiveTabFileName == "" and "  [ UNKNOWN ] " or "%{% v:lua.get_ft_icon('a', " .. tabnr .. ") %}" .. ActiveTabFileName:gsub(".*/", '') .. ActiveTabIndicator

    local ActiveTabContent   = "%#ActiveTab#" .. ActiveTabFileName

    -- return "%#ActiveTabSepL# " .. ActiveTabContent .. " %#ActiveTabSepR#"
    return "%#ActiveTabSepL#" .. ActiveTabContent .. " %#ActiveTabSepR#"
end

function _G._tabline_get_mod_status (tabnr)
    local bufnr_list = vim.fn.tabpagebuflist(tabnr)
    for i = 1, #bufnr_list do
        if vim.fn.getbufvar(bufnr_list[i], '&mod') == 1 then
            return 1
        end
    end
    return 0
end


function _G.nvim_tabline ()

    local tabLine = "%#TabLineP#%3@v:lua._nvim_tabline_prefix@  "

    local tabtotal = fn.tabpagenr("$")

    if tabtotal == 1 then
        tabLine = tabLine .. GenActiveTab(1)
    else
        for i = 1, tabtotal do
            if i == api.nvim_tabpage_get_number(0) then
                tabLine = tabLine .. GenActiveTab(i)
            else
                tabLine = tabLine .. GenInactiveTab(i)
            end
        end
    end

    -- return tabLine .. "%T %#TabLine# %= %#TabLineX# %1X%X "
    return tabLine .. "%T%2@v:lua._nvim_tabline_plus@%#TabNew#+ %#TabLine# %= %#TabLineX#%3@v:lua._nvim_tabline_close@  %X"
end

function _G._nvim_tabline_prefix ()
    api.nvim_command("tabnext")
end

function _G._nvim_tabline_plus ()
    api.nvim_command("tabnew")
end

function _G._nvim_tabline_close ()
    if fn.tabpagenr("$") == 1 then
        api.nvim_command "quitall!"
        -- os.execute("kitty @ --to unix:/tmp/kitty.sock close-tab")
    else
        api.nvim_command "tabclose"
    end
end

opt.tabline = "%!v:lua.nvim_tabline()"

local TabLineHL = {

    TabLine   = { bg = "#111111", fg = "#666666" },
    TabLineP  = { bg = "#111111", fg = "#C53B82" },
    TabLineX  = { bg = "#111111", fg = "#C53B82" },
    TabNew    = { bg = "#111111", fg = "#202020" },

    InactiveTab     = { bg = "#202020", fg = "#444444", italic =  true },
    InactiveTabX    = { bg = "#202020", fg = "#444444" },
    InactiveTabMod  = { bg = "#202020", fg = "#444444" },

    InactiveTabSepL  = { bg = "#111111", fg = "#202020" },
    InactiveTabSepR  = { bg = "#111111", fg = "#202020" },

    ActiveTab      = { bg = "#232323", fg = "#777777", bold = true, italic = true },
    ActiveTabX     = { bg = "#232323", fg = "#777777" },
    ActiveTabMod   = { bg = "#232323", fg = "#AFC460" },

    ActiveTabSepL  = { bg = "#111111", fg = "#232323" },
    ActiveTabSepR  = { bg = "#111111", fg = "#232323" },
}

for key, value in pairs(TabLineHL) do
    api.nvim_set_hl(0, key, value)
end
