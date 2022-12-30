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

-- local timer = vim.loop.new_timer()
-- vim.on_key(function()
--   timer:start(2000, 0, function()
--     print("Helloo")
--   end)
-- end)

vim.defer_fn(function ()
    require "core.options"     -- ~/nvim/lua/core/options.lua
    require "core.keymaps"     -- ~/nvim/lua/core/keymaps.lua
    require "core.autocmd"     -- ~/nvim/lua/core/autocmd.lua
    require "plugins"          -- ~/nvim/lua/plugins/init.lua

    vim.o.shadafile = ""

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

-- vim.keymap.set("n", ";d", function ()
--     local time = os.clock()
--
--     for i = 1, 10000000 do
--         api.nvim_set_keymap("n", "J", "G", { noremap = true })
--     end
--
--     print((os.clock() - time) * 100)
-- end)
