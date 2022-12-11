
local uv = vim.loop
local api = vim.api

local plugin_list = {
    "lewis6991/impatient.nvim.git",
    "norcalli/nvim-colorizer.lua.git",
    "nvim-treesitter/nvim-treesitter.git",
    "nvim-treesitter/nvim-treesitter-textobjects.git",
    "nvim-treesitter/nvim-treesitter-context.git",
}

-- require "colorizer".setup({ "*" }, { mode = "foreground" })

local function install_plugin ()

    local plugin_dir = nil

    for i = 1, #plugin_list do

        plugin_dir = " /home/nex/.local/share/nvim/site/pack/plugins/opt/" .. plugin_list[i]:gsub(".*/", '')

        os.execute("mkdir -p" .. plugin_dir)
        os.execute("git clone git@github.com:" .. plugin_list[i] .. plugin_dir)
    end
end

local function update_plugin ()

    local plugin_dir = nil

    for i = 1, #plugin_list do
        plugin_dir = " /home/nex/.local/share/nvim/site/pack/plugins/opt/" .. plugin_list[i]:gsub(".*/", '')
        os.execute("cd" .. plugin_dir .. "&& git pull")
    end

end

api.nvim_create_user_command("PlugUpdate", update_plugin, {})

api.nvim_create_user_command("PlugInstall", install_plugin, {})
