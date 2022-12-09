--     __  ___   _________  __ ____  ____________________________   --
--    / / / / | / / ____/ |/ // __ \/ ____/ ____/_  __/ ____/ __ \  --
--   / / / /  |/ / __/  |   // /_/ / __/ / /     / / / __/ / / / /  --
--  / /_/ / /|  / /___ /   |/ ____/ /___/ /___  / / / /___/ /_/ /   --
--  \____/_/ |_/_____//_/|_/_/   /_____/\____/ /_/ /_____/_____/    --
--                                                                  --

-- TODO: h operatorfunc

-- require "impatient"

-- pcall(vim.cmd, "luafile ~/.config/nvim/plugin/packer_compiled.lua")


require "UI"                -- ~/.config/nvim/lua/UI/init.lua
vim.defer_fn(function ()

    require "core.options"  -- ~/nvim/config/lua/core/options.lua
    require "core.keymaps"  -- ~/nvim/config/lua/core/keymaps.lua
    require "core.autocmd"  -- ~/nvim/config/lua/core/autocmd.lua
    -- require "core.filetype" -- ~/nvim/config/lua/core/filetype.lua
    require "plugins"       -- ~/nvim/config/lua/plugins/init.lua
end, 10)

vim.defer_fn(function ()

    vim.cmd [[
        syntax on " THIS WILL AUTO OPEN filetype
        " filetype plugin indent on
        " source ~/nvim/config/plugin/matchparen.vim
    ]]
end, 20)
