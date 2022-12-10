local api = vim.api
local utils = require "utils"

local M = {
    bufnr = nil,
    winnr = nil,
    action = "tabnew ",
    vifm_action = {},
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

    local vifm_action = {
        ["<C-v>"] = function ()
            M.action = "vsp"
            return "<CR>"
        end,
        ["<C-s>"] = function ()
            M.action = "sp"
            return "<CR>"
        end,
    }

    local dir = "."
    if args ~= nil then
        dir = args.args
    end

    M.bufnr = api.nvim_create_buf(false, true)
    M.winnr = utils.open_win_float(M.bufnr, {})

    vim.cmd "startinsert"
    vim.fn.termopen("vifm " .. dir .. " --choose-files /tmp/nvim-vifm", { on_exit = open_file })

    M.action = "tabnew "

    for lhs, rhs in pairs(vifm_action) do
        vim.keymap.set("t", lhs, rhs, { buffer = true, expr = true })
    end

    vim.keymap.set("t", "<ESC>", "<CMD>quit<CR>", { buffer = true })

end

local function FZF ()

    local fzf_action = {
        ["<C-v>"] = function ()
            M.action = "vsp "
            return "<CR>"
        end,
        ["<C-s>"] = function ()
            M.action = "sp "
            return "<CR>"
        end,
        ["<C-l>"] = function ()
            M.action = "tabedit "
            return "<CR>"
        end,
    }

    M.bufnr = api.nvim_create_buf(false, true)
    M.winnr = utils.open_win_float(M.bufnr, {})

    vim.cmd "startinsert"
    vim.fn.termopen("fzf --preview 'bat --theme=Nord --style=plain --color=always --line-range :40 {}' > /tmp/nvim-vifm", { on_exit = open_file })

    M.action = "tabnew "

    for lhs, rhs in pairs(fzf_action) do
        vim.keymap.set("t", lhs, rhs, { buffer = true, expr = true })
    end

    vim.keymap.set("t", "<ESC>", "<CMD>quit<CR>", { buffer = true })
end

api.nvim_create_user_command("F", VIFM, {
    nargs = "?",
    complete = "dir",
})

-- TODO: First Open
-- M.bufnr = api.nvim_create_buf(false, true)
-- vim.fn.termopen("vifm " .. dir .. " --choose-files /tmp/nvim-vifm", { on_exit = open_file })

vim.keymap.set("n", ";e", VIFM, { silent = true })
vim.keymap.set("n", "<C-f>", FZF, { silent = true })

-- ["<C-f>"] = function ()
--     local opts = {
--         start_ins = true,
--         resume    = false,
--         term_name = "fzf",
--         exit_key  = "<ESC>",
--     }
--     local cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :100 {}'"
--     require "plugins.terminal".open_term_float(cmd, opts, { title = " [ TERMINAL ] ", title_pos = "right" })
-- end,

