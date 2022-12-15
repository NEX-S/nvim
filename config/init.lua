--     __  ___   _________  __ ____  ____________________________   --
--    / / / / | / / ____/ |/ // __ \/ ____/ ____/_  __/ ____/ __ \  --
--   / / / /  |/ / __/  |   // /_/ / __/ / /     / / / __/ / / / /  --
--  / /_/ / /|  / /___ /   |/ ____/ /___/ /___  / / / /___/ /_/ /   --
--  \____/_/ |_/_____//_/|_/_/   /_____/\____/ /_/ /_____/_____/    --
--                                                                  --

-- TODO: h operatorfunc

-- vim.cmd [[ packadd impatient.nvim.git ]]
-- require "impatient"
-- TODO: ctrl+;

require "UI"                -- ~/.config/nvim/lua/UI/init.lua
require "core.filetype"     -- ~/nvim/config/lua/core/filetype.lua

vim.defer_fn(function ()
    require "core.options"     -- ~/nvim/config/lua/core/options.lua
    require "core.keymaps"     -- ~/nvim/config/lua/core/keymaps.lua
    require "core.autocmd"     -- ~/nvim/config/lua/core/autocmd.lua
    require "plugins"          -- ~/nvim/config/lua/plugins/init.lua

    require "plug-manager"  -- ~/nvim/config/lua/plug-manager/init.lua

    vim.o.shadafile = ""

    vim.cmd [[
        rshada!
        packadd matchparen.nvim
        packadd nvim-colorizer.lua.git
        ]]

    require "matchparen".setup()

    vim.cmd [[
        " set foldmethod=indent
        " set foldexpr=nvim_treesitter#foldexpr()
        " set nofoldenable
        ]]

end, 106)

vim.defer_fn(function ()

    -- vim.o.shadafile = "~/.cache/nvim/shada"
    -- vim.o.shada = "'10,<1,s1,:0,no /,no %,no h,n~/.cache/nvim/shada"

    require "plug-manager.treesitter"  -- ~/.config/nvim/lua/plug-manager/treesitter.lua

end, 20)

require "colorizer".setup({ "*" }, { mode = "foreground" })

