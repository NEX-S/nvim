--     __  ___   _________  __ ____  ____________________________   --
--    / / / / | / / ____/ |/ // __ \/ ____/ ____/_  __/ ____/ __ \  --
--   / / / /  |/ / __/  |   // /_/ / __/ / /     / / / __/ / / / /  --
--  / /_/ / /|  / /___ /   |/ ____/ /___/ /___  / / / /___/ /_/ /   --
--  \____/_/ |_/_____//_/|_/_/   /_____/\____/ /_/ /_____/_____/    --
--                                                                  --

-- TODO: h operatorfunc

vim.o.rtp = "/home/nex/.local/share/nvim/lazy/lazy.nvim,/home/nex/nvim,/usr/share/nvim/runtime"

require "plugins.lazy"

local api = vim.api

-- api.nvim_command("packadd impatient.nvim")
-- require          "impatient"

require "UI"                -- ~/nvim/lua/UI/init.lua
require "core.filetype"     -- ~/nvim/config/lua/core/filetype.lua

vim.defer_fn(function ()
    require "core.options"     -- ~/nvim/lua/core/options.lua
    require "core.keymaps"     -- ~/nvim/lua/core/keymaps.lua
    require "core.autocmd"     -- ~/nvim/lua/core/autocmd.lua
    require "plugins"          -- ~/nvim/lua/plugins/init.lua

    -- require "plug-manager"     -- ~/nvim/config/lua/plug-manager/init.lua

    vim.o.shadafile = ""

    -- api.nvim_exec ([[
    --     packadd matchparen.nvim
    --     packadd nvim-colorizer.lua
    --
    --     packadd nvim-treesitter-textobjects
    --
    --     packadd matchit
    --     let b:match_ignorecase = 0
    --     let b:match_words =
    --         \ '\<\%(do\|function\|if\)\>:' ..
    --         \ '\<\%(return\|else\|elseif\)\>:' ..
    --         \ '\<end\>,' ..
    --         \ '\<repeat\>:\<until\>,' ..
    --         \ '\%(--\)\=\[\(=*\)\[:]\1]'
    -- ]], false)
    -- require "matchparen".setup()
    -- require "colorizer".setup({ "*" }, { mode = "foreground" })

end, 150)

-- vim.defer_fn(function ()
--     -- api.nvim_command [[
--     --     " packadd nvim-treesitter-context
--     -- ]]
--
--     -- vim.o.shadafile = "~/.cache/nvim/shada"
--     -- vim.o.shada = "'10,<1,s1,:0,no /,no %,no h,n~/.cache/nvim/shada"
--     -- require "plug-manager.treesitter"  -- ~/nvim/lua/plug-manager/treesitter.lua
--
-- end, 10)

-- USE LOCAL VAR!!!
-- VIML SPEED    : api.nvim_command < api.nvim_exec(xxx, false) < api.nvim_exec(xxx, true) < vim.cmd < vim.cmd.xxx < others
-- VIMFUNC SPEED : vim.call("xxx")  = vim.fn.xxx = vim.fn['xxx'] = api.nvim_call_function
-- KEYMAP rhs    : gt < vim.cmd.xxx < <cmd>xxx<CR>
-- OPTION set    : vim.o.xxx < map + true < api.nvim_command < map + ipairs
-- KEYMAP set    : api.nvim_set_keymap + table !!! termcode can't use in nvim_set_keymap
-- var           : api.nvim_buf_get_option < vim.bo.xxx

-- vim.keymap.set("n", ";d", function ()
--     local time = os.clock()
--
--     for i = 1, 1000000 do
--
--     enda
--
--     print((os.clock() - time) * 100)
-- end)
