-- TODO: 
local api = vim.api

local switch_map = {
    ["true"] = "false",
    ["True"] = "False",
    ["TRUE"] = "FALSE",

    ["false"] = "true",
    ["False"] = "True",
    ["FALSE"] = "TRUE",

    ["<"]  = ">=",
    [">"]  = "<=",
    ["<="] = ">",
    [">="] = "<",
    ["=="] = "!=",

    ["!="] = "==",
    [">="] = "<",
    ["<="] = ">",
    [">"]  = "<=",
    ["<"]  = ">=",

    ["0"] = "1",
    ["1"] = "0",
}

vim.keymap.set("n", "<C-o>", function ()
    local cword = vim.fn.expand("<cWORD>")
    local nword = switch_map[cword] or ""

    return nword == "" and "" or "ciw" .. nword .. "<ESC>"
end, { expr = true })
