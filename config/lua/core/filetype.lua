
local api = vim.api

local ft_dict = {
    lua  = "lua",
    c    = "c",
    py   = "python",
    fish = "fish",
    vim  = "vim",
    vifmrc = "vim",
}

local ext = nil
local function ft_detect ()
    -- ext = api.nvim_buf_get_name(0):gsub(".*/", '')

    local fileExt  = vim.fn.expand("%:e")
    local fileName = vim.fn.expand("%:t")

    vim.bo.ft = fileExt ~= "" and ft_dict[fileExt] or ft_dict[fileName]

    vim.defer_fn(function()
        pcall(vim.cmd, "luafile ~/nvim/config/after/ftplugin/" .. vim.bo.ft .. ".lua")
    end, 150)
end

ft_detect()

api.nvim_create_autocmd({ "BufWinEnter" }, { callback = ft_detect })
