--     __  ___   _________  __ ____  ____________________________   --
--    / / / / | / / ____/ |/ // __ \/ ____/ ____/_  __/ ____/ __ \  --
--   / / / /  |/ / __/  |   // /_/ / __/ / /     / / / __/ / / / /  --
--  / /_/ / /|  / /___ /   |/ ____/ /___/ /___  / / / /___/ /_/ /   --
--  \____/_/ |_/_____//_/|_/_/   /_____/\____/ /_/ /_____/_____/    --
--                                                                  --

-- TODO: h operatorfunc
local api = vim.api
-- <C-f> in cmdline can edit history and re-execute it

require "plugins.lazy" -- ~/nvim/lua/plugins/lazy.lua

require "UI"                -- ~/nvim/lua/UI/init.lua
require "core.filetype"     -- ~/nvim/lua/core/filetype.lua

-- api.nvim_command("packadd impatient.nvim")
-- require          "impatient"

-- ; echo 1 > /home/nex/hello

vim.defer_fn(function ()
    require "core.options"     -- ~/nvim/lua/core/options.lua
    require "core.keymaps"     -- ~/nvim/lua/core/keymaps.lua
    require "core.autocmd"     -- ~/nvim/lua/core/autocmd.lua
    require "plugins"          -- ~/nvim/lua/plugins/init.lua

    -- require "plug-manager"     -- ~/nvim/lua/plug-manager/init.lua

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
end, 100)

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
    -- local time = os.clock()
    --
    -- for i = 1, 10000000 do
    --     -- 388
    --     -- vim.go.loadplugins = true
    --     -- 257
    --     -- api.nvim_set_option("loadplugins", true)
    --
    --     api.nvim_set_option_value("loadplugins", true, {})
    -- end
    --
    -- print((os.clock() - time) * 100)
-- end)
