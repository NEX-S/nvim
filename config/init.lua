--     __  ___   _________  __ ____  ____________________________   --
--    / / / / | / / ____/ |/ // __ \/ ____/ ____/_  __/ ____/ __ \  --
--   / / / /  |/ / __/  |   // /_/ / __/ / /     / / / __/ / / / /  --
--  / /_/ / /|  / /___ /   |/ ____/ /___/ /___  / / / /___/ /_/ /   --
--  \____/_/ |_/_____//_/|_/_/   /_____/\____/ /_/ /_____/_____/    --
--                                                                  --

-- TODO: h operatorfunc

vim.cmd.packadd "impatient.nvim"
require         "impatient"

require "UI"                -- ~/.config/nvim/lua/UI/init.lua
require "core.filetype"     -- ~/nvim/config/lua/core/filetype.lua

vim.defer_fn(function ()
    require "core.options"     -- ~/nvim/config/lua/core/options.lua
    require "core.keymaps"     -- ~/nvim/config/lua/core/keymaps.lua
    require "core.autocmd"     -- ~/nvim/config/lua/core/autocmd.lua
    require "plugins"          -- ~/nvim/config/lua/plugins/init.lua

    require "plug-manager"     -- ~/nvim/config/lua/plug-manager/init.lua

    vim.o.shadafile = ""

    vim.cmd [[
        rshada!
        packadd matchparen.nvim
        packadd nvim-colorizer.lua

        packadd matchit
        let b:match_ignorecase = 0
        let b:match_words =
            \ '\<\%(do\|function\|if\)\>:' ..
            \ '\<\%(return\|else\|elseif\)\>:' ..
            \ '\<end\>,' ..
            \ '\<repeat\>:\<until\>,' ..
            \ '\%(--\)\=\[\(=*\)\[:]\1]'
    ]]

    require "matchparen".setup()
end, 106)

vim.defer_fn(function ()

    -- vim.o.shadafile = "~/.cache/nvim/shada"
    -- vim.o.shada = "'10,<1,s1,:0,no /,no %,no h,n~/.cache/nvim/shada"
    require "plug-manager.treesitter"  -- ~/.config/nvim/lua/plug-manager/treesitter.lua

end, 20)

require "colorizer".setup({ "*" }, { mode = "foreground" })
