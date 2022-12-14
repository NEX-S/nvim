--     __  ___   _________  __ ____  ____________________________   --
--    / / / / | / / ____/ |/ // __ \/ ____/ ____/_  __/ ____/ __ \  --
--   / / / /  |/ / __/  |   // /_/ / __/ / /     / / / __/ / / / /  --
--  / /_/ / /|  / /___ /   |/ ____/ /___/ /___  / / / /___/ /_/ /   --
--  \____/_/ |_/_____//_/|_/_/   /_____/\____/ /_/ /_____/_____/    --
--                                                                  --

-- TODO: h operatorfunc
-- TODO: add cmd that can search sth in chrome
local api = vim.api
-- <C-f> in cmdline can edit history and re-execute it

-- vim.defer_fn(function ()
--     require "core.options"     -- ~/nvim/lua/core/options.lua
--     require "core.keymaps"     -- ~/nvim/lua/core/keymaps.lua
--     require "core.autocmd"     -- ~/nvim/lua/core/autocmd.lua
--     require "plugins"          -- ~/nvim/lua/plugins/init.lua
-- end, 100)

-- vim.bo.syntax = "on"
-- vim.g.ts_highlight_lua = true
require "plugins.lazy" -- ~/nvim/lua/plugins/lazy.lua

require "UI"                -- ~/nvim/lua/UI/init.lua
require "core.filetype"     -- ~/nvim/lua/core/filetype.lua

vim.defer_fn(function()
    api.nvim_command("silent! loadview")
end, 0)

api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function ()
        require "core.options"     -- ~/nvim/lua/core/options.lua
        require "core.keymaps"     -- ~/nvim/lua/core/keymaps.lua
        require "core.autocmd"     -- ~/nvim/lua/core/autocmd.lua
        require "plugins"          -- ~/nvim/lua/plugins/init.lua
    end,
})

-- vim.keymap.set("n", ";d", function ()
--     local time = os.clock()
--
--     for i = 1, 10000000 do
--         api.nvim_set_keymap("n", "J", "G", { noremap = true })
--     end
--
--     print((os.clock() - time) * 100)
-- end)

