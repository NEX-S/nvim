
local api = vim.api

local filetype_dict = {
    c    = "c",
    sh   = "bash",
    py   = "python",
    md   = "markdown",
    lua  = "lua",
    vim  = "vim",
    fish = "fish",
    conf = "conf",
    html = "html",
}

local filename_dict = {
    vifmrc = "vim",
}

local ext = nil
local function ft_detect ()
    local fileExt  = vim.fn.expand("%:e")
    local fileName = vim.fn.expand("%:t")

    local ft = fileExt ~= "" and filetype_dict[fileExt] or filename_dict[fileName] or fileName
    api.nvim_set_option_value("filetype", ft, {})

    vim.defer_fn(function()
        pcall(api.nvim_command, "luafile ~/nvim/after/ftplugin/" .. vim.bo.ft .. ".lua")
    end, 150)
end

ft_detect()

api.nvim_create_autocmd({ "BufWinEnter" }, { callback = ft_detect })
