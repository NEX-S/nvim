
local api = vim.api

local ft_dict = {
    lua = "lua",
    c   = "c",
    py  = "python",
    fish  = "fish",
}

local ext = nil
local function ft_detect ()
    ext = api.nvim_buf_get_name(0):gsub(".*%.", '')
    vim.bo.ft = ft_dict[ext] or "UNKNOWN"
    pcall(vim.cmd, "luafile ~/nvim/config/after/ftplugin/" .. vim.bo.ft .. ".lua")
end

ft_detect()

api.nvim_create_autocmd({ "BufWinEnter" }, { callback = ft_detect })
