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
    require "core.options"  -- ~/.config/nvim/lua/core/options.lua
    require "core.keymaps"  -- ~/.config/nvim/lua/core/keymaps.lua
    require "core.autocmd"  -- ~/.config/nvim/lua/core/autocmd.lua
    require "core.filetype" -- ~/.config/nvim/lua/core/filetype.lua
    require "plugins"       -- ~/.config/nvim/lua/plugins/init.lua
end, 10)

vim.defer_fn(function ()
    vim.cmd [[
        syntax on
        filetype plugin indent on
        source ~/.config/nvim/plugin/matchparen.vim
    ]]
end, 18)
