
local api = vim.api

local term = require "plugins.terminal"

function _G.plugin_manager (args)

    local term_opts = {
        start_ins = false,
        resume    = true,
        term_name = "plugin-manager",
        exit_key  = "<ESC>",
    }

    local plugin_manager_script = "/home/nex/nvim/config/lua/plug-manager/plugin-manager.lua "

    term.open_term_float("lua " .. plugin_manager_script .. args,  term_opts, { title = " [ PLUGIN ] ",  title_pos = "right" })

    -- term.open_term_float("lua " .. plugin_manager_script .. " remove",  term_opts, { title = " [ REMOVE PLUGIN ] ",  title_pos = "right" })
    -- term.open_term_float("lua " .. plugin_manager_script .. " install", term_opts, { title = " [ INSTALL PLUGIN ] ", title_pos = "right" })
end

api.nvim_create_user_command("PlugUpdate",  "lua plugin_manager('update')",  {})
api.nvim_create_user_command("PlugRemove",  "lua plugin_manager('remove')",  {})
api.nvim_create_user_command("PlugInstall", "lua plugin_manager('install')", {})

