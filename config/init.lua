--     __  ___   _________  __ ____  ____________________________   --
--    / / / / | / / ____/ |/ // __ \/ ____/ ____/_  __/ ____/ __ \  --
--   / / / /  |/ / __/  |   // /_/ / __/ / /     / / / __/ / / / /  --
--  / /_/ / /|  / /___ /   |/ ____/ /___/ /___  / / / /___/ /_/ /   --
--  \____/_/ |_/_____//_/|_/_/   /_____/\____/ /_/ /_____/_____/    --
--                                                                  --

-- TODO: h operatorfunc

-- require "impatient"

-- pcall(vim.cmd, "luafile ~/.config/nvim/plugin/packer_compiled.lua")

-- vim.defer_fn(function ()
-- end, 4)

-- _G.package.path = "./?.lua"

vim.defer_fn(function ()
    require "UI"                -- ~/.config/nvim/lua/UI/init.lua
    vim.cmd [[
        " syntax on " THIS WILL AUTO OPEN filetype
        " filetype plugin indent on
        " source ~/nvim/config/plugin/matchparen.vim
    ]]
end, 5)

vim.defer_fn(function ()

    require "core.options"  -- ~/nvim/config/lua/core/options.lua
    require "core.keymaps"  -- ~/nvim/config/lua/core/keymaps.lua
    require "core.autocmd"  -- ~/nvim/config/lua/core/autocmd.lua
    require "core.filetype" -- ~/nvim/config/lua/core/filetype.lua
    require "plugins"       -- ~/nvim/config/lua/plugins/init.lua

end, 107)

-- local async = nil
-- async = vim.loop.new_async (
--     vim.schedule_wrap ( function ()
--         require "core.options"  -- ~/nvim/config/lua/core/options.lua
--         require "core.keymaps"  -- ~/nvim/config/lua/core/keymaps.lua
--         require "core.autocmd"  -- ~/nvim/config/lua/core/autocmd.lua
--         -- require "core.filetype" -- ~/nvim/config/lua/core/filetype.lua
--         require "plugins"       -- ~/nvim/config/lua/plugins/init.lua
--         async:close()
--     end)
-- )
--
-- async:send()

-- local uv = vim.loop
--
-- local callback
-- callback = uv.new_async (vim.schedule_wrap (
--  function ()
--      require "core.options"  -- ~/nvim/config/lua/core/options.lua
--      require "core.keymaps"  -- ~/nvim/config/lua/core/keymaps.lua
--      require "core.autocmd"  -- ~/nvim/config/lua/core/autocmd.lua
--      -- require "core.filetype" -- ~/nvim/config/lua/core/filetype.lua
--      require "plugins"       -- ~/nvim/config/lua/plugins/init.lua
--      uv.close(callback)
--  end)
-- )
--
-- local function task (id, time, callback)
--     local uv = vim.loop
--     -- uv.sleep(time)
--     uv.async_send(callback, 1)
-- end
--
-- uv.new_thread(task, 1, 10, callback)

