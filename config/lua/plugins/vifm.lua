local api = vim.api
local utils = require "utils"

local M = {
    bufnr = nil,
    winnr = nil,
    action = "tabnew ",
    vifm_action = {},
}

M.vifm_action = {
    ["<ESC>"] = function ()
        return ";q"
    end,
    ["<C-v>"] = function ()
        M.action = "vsp"
        return "l"
    end,
    ["<C-s>"] = function ()
        M.action = "sp"
        return "l"
    end,
}

local function open_file ()

    api.nvim_win_close(M.winnr, true)

    for line in io.lines("/tmp/nvim-vifm") do
        vim.cmd(M.action .. line)
    end

    api.nvim_buf_delete(M.bufnr, { force = true })
    vim.loop.new_thread(function ()
        os.remove("/tmp/nvim-vifm")
    end)
end

-- TODO: --choose-files - RPC 
local function VIFM (args)
    local dir = "."
    if args ~= nil then
        dir = args.args
    end

    M.bufnr = api.nvim_create_buf(false, true)
    M.winnr = utils.open_win_float(M.bufnr, {})

    vim.cmd "startinsert"
    vim.fn.termopen("vifm " .. dir .. " --choose-files /tmp/nvim-vifm", { on_exit = open_file })

    M.action = "tabnew "
    for lhs, rhs in pairs(M.vifm_action) do
        vim.keymap.set("t", lhs, rhs, { buffer = true, expr = true })
    end

end

api.nvim_create_user_command("F", VIFM, {
    nargs = "?",
    complete = "dir",
})

-- TODO: First Open
-- M.bufnr = api.nvim_create_buf(false, true)
-- vim.fn.termopen("vifm " .. dir .. " --choose-files /tmp/nvim-vifm", { on_exit = open_file })

vim.keymap.set("n", ";e", VIFM, { silent = true })
