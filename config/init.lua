--     __  ___   _________  __ ____  ____________________________   --
--    / / / / | / / ____/ |/ // __ \/ ____/ ____/_  __/ ____/ __ \  --
--   / / / /  |/ / __/  |   // /_/ / __/ / /     / / / __/ / / / /  --
--  / /_/ / /|  / /___ /   |/ ____/ /___/ /___  / / / /___/ /_/ /   --
--  \____/_/ |_/_____//_/|_/_/   /_____/\____/ /_/ /_____/_____/    --
--                                                                  --

-- TODO: h operatorfunc

vim.cmd [[ packadd impatient.nvim.git ]]

require "impatient".enable_profile()

-- pcall(vim.cmd, "luafile ~/.config/nvim/plugin/packer_compiled.lua")

-- vim.defer_fn(function ()
-- end, 4)

-- _G.package.path = "./?.lua"


    require "UI"                -- ~/.config/nvim/lua/UI/init.lua
    require "core.filetype"     -- ~/nvim/config/lua/core/filetype.lua

-- vim.defer_fn(function ()
-- end, 5)

vim.defer_fn(function ()
    require "core.options"     -- ~/nvim/config/lua/core/options.lua
    require "core.keymaps"     -- ~/nvim/config/lua/core/keymaps.lua
    require "core.autocmd"     -- ~/nvim/config/lua/core/autocmd.lua
    require "plugins"          -- ~/nvim/config/lua/plugins/init.lua
    -- require "plug-manager"  -- ~/nvim/config/lua/plug-manager/init.lua
end, 107)


vim.defer_fn(function ()
    require "plug-manager.treesitter"  -- ~/.config/nvim/lua/plug-manager/treesitter.lua

    vim.cmd [[ packadd nvim-colorizer.lua.git ]]
end, 20)

require "colorizer".setup({ "*" }, { mode = "foreground" })

-- syntax on " THIS WILL AUTO OPEN filetype
-- filetype plugin indent on
-- TODO: rewrite matchparen
-- source ~/nvim/config/plugin/matchparen.vim

