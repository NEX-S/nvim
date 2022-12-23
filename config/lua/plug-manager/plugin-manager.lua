
local args = { ... }

local action = args[1]

local plugin_list = {
    "lewis6991/impatient.nvim",
    "norcalli/nvim-colorizer.lua",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "nex-s/matchparen.nvim",
}

local plugin_dir = nil

if action == "install" then
    for i = 1, #plugin_list do
        plugin_dir = "/home/nex/.local/share/nvim/site/pack/plugins/opt/" .. plugin_list[i]:gsub(".*/", '')
        os.execute("mkdir -p " .. plugin_dir)

        print("[ INSTALLING " .. plugin_list[i]:gsub(".*/", '') .. " ... ]")

        os.execute("git clone git@github.com:" .. plugin_list[i] .. ".git " .. plugin_dir)
        print("")
    end
elseif action == "update" then
    for i = 1, #plugin_list do
        plugin_dir = "/home/nex/.local/share/nvim/site/pack/plugins/opt/" .. plugin_list[i]:gsub(".*/", '')

        print("[ UPDATING " .. plugin_list[i]:gsub(".*/", '') .. " ... ]")

        os.execute("cd " .. plugin_dir .. "&& git pull")
        print("")
    end
elseif action == "remove" then
    print("rm -rf /home/nex/.local/share/nvim/*")
    os.execute("rm -rf /home/nex/.local/share/nvim/*")
    print("\nDONE")
end
