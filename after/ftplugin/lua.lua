local api = vim.api
local utils = require "utils"

local bo = vim.bo

-- require "UI.x-color".set_hl {
--     LuaFunc    = { bg = "NONE", fg = "#9C8FDC" },
--     LuaError   = { bg = "NONE", fg = "#444444" },
--     LuaReturn  = { bg = "NONE", fg = "#C53B82" },
--     LuaLogic   = { bg = "NONE", fg = "#9C8FDC" },
--     LuaRequire = { bg = "NONE", fg = "#AFC460" },
--     LuaPcall   = { bg = "NONE", fg = "#C53B82" },
--     LuaParen   = { bg = "NONE", fg = "#9C8FDC" },
--     LuaTODO    = { bg = "NONE", fg = "#9C8FDC" },
--
--     LuaParenError  = { bg = "NONE", fg = "#C53B82" },
--
--     NvimApi     = { bg = "NONE", fg = "#AFC460" },
--     NvimApiCall = { bg = "NONE", fg = "#AFC460" },
--     NvimFunc    = { bg = "NONE", fg = "#C53B82" },
--     NvimCmd     = { bg = "NONE", fg = "#C53B82" },
-- }

vim.defer_fn(function ()

    bo.comments = ":--"
    bo.formatoptions = "tcqjr"

    local lua_keymap = {
        ["gh"] = function ()
            vim.cmd("vert help " .. vim.fn.expand("<cword>") .. "| vert resize 80")
            vim.wo.sidescrolloff = 0
            vim.keymap.set("n", "<ESC>", "<CMD>quit!<CR>", { buffer = true })
        end,
        -- [",r"] = "<CMD>source %<CR>",
        [",,"] = function ()
            local opts = {
                title = " [ LUA TEST ] ",
                title_pos = "right",
            }

            local bufnr = api.nvim_create_buf(false, false)
            local winid = utils.open_win_float(bufnr, opts)

            vim.cmd.edit("~/test/test.lua")

            vim.wo.number = true
            vim.wo.numberwidth = 3

            local lua_test_map = {
                [",q"] = "<CMD>source ~/nvim/init.lua | quit!<CR>",
                [",,"] = "<CMD>source ~/nvim/init.lua | quit!<CR>",
                [",r"] = "<CMD>write! | source %<CR>",
            }

            for lhs, rhs in pairs(lua_test_map) do
                vim.keymap.set("n", lhs, rhs, { buffer = true })
            end
        end,
    }

    for lhs, rhs in pairs(lua_keymap) do
        vim.keymap.set("n", lhs, rhs, { silent = true })
    end


    local lua_dict = {
        "nvim_set_hl",
        "nvim_buf_get_lines",
        "nvim_buf_set_lines",
        "nvim_buf_set_text",
        "nvim_create_augroup",
        "nvim_create_autocmd",
        "nvim_create_namespace",
        "nvim_create_user_command",
        "nvim_get_current_buf",
        "nvim_get_current_line",
        "nvim_get_current_win",
        "nvim_get_mode",
        "nvim_open_win",
        "nvim_win_get_cursor",
        "nvim_win_set_cursor",

        "pumvisible",
        "col",
        "getpos",
    }

    function _G.lua_completefunc (findstart, base)
        if findstart == 1 then
            local col = api.nvim_win_get_cursor(0)[2]
            local str = api.nvim_get_current_line():sub(1, col - 1)
            -- local _, res = str:find(".*[^%a]")
            local _, res = str:find(".*%.")
            return res
        else
            local filter = base .. ".*"
            for i = 1, #lua_dict do
                if lua_dict[i]:match(filter) then
                    vim.fn.complete_add({ word = lua_dict[i], kind = "[NVIM]" })
                end
                if vim.fn.complete_check() == true then
                    return nil
                end
            end
        end
    end

    bo.completefunc = "v:lua.lua_completefunc"
    bo.dictionary = "~/nvim/dict/lua.dict"

    -- vim.cmd [[
    --     syntax keyword LuaReturn  "return"
    --     syntax keyword LuaLogic   "and or not"
    --     syntax keyword LuaRequire "require"
    --     syntax keyword LuaPcall   "pcall"
    --     syntax keyword LuaTODO   "TODO"
    --
    --     syntax match NvimApi       "vim\.api"
    --     syntax match NvimApiCall   "\v(vim\.)?api\.\h*(\(.*\))?"
    --     syntax match NvimFunc      "\v(vim\.)?fn\.\h*"
    --     syntax match NvimCmd       "\vvim.cmd.*"
    -- ]]

    function _G._P(data)
        vim.pretty_print(data)
    end

end, 150)
