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
        if M.action == "tabnew " and api.nvim_buf_get_name(0) == "" then
            api.nvim_command("edit " .. line)
        else
            api.nvim_command(M.action .. line)
        end
    end

    api.nvim_buf_delete(M.bufnr, { force = true })

    vim.loop.new_thread(function ()
        os.remove("/tmp/nvim-vifm")
    end)
end

-- TODO: --choose-files - RPC
local function VIFM (opts)

    local vifm_action = {
        ["<C-v>"] = function ()
            M.action = "vsp"
            return "l"
        end,
        ["<C-s>"] = function ()
            M.action = "sp"
            return "l"
        end,
    }

    local dir = vim.fn.expand("%:p:h")
    if opts ~= nil then
        dir = opts.args
    end

    M.bufnr = api.nvim_create_buf(false, true)
    M.winnr = utils.open_win_float(M.bufnr, { border = "none" })

    api.nvim_command "startinsert"
    vim.fn.termopen("vifm " .. dir .. " --choose-files /tmp/nvim-vifm", { on_exit = open_file })

    M.action = "tabnew "

    for lhs, rhs in pairs(vifm_action) do
        vim.keymap.set("t", lhs, rhs, { buffer = true, expr = true })
    end

    vim.keymap.set("t", "<ESC>", "<CMD>quit<CR>", { buffer = true })

end

local function FZF (opts)

    local dir = vim.fn.expand("%:p:h")

    if opts ~= nil then
        dir = opts.args
    end

    local fzf_action = {
        ["<C-v>"] = function ()
            M.action = "vsp "
            return "<RIGHT>"
        end,
        ["<C-s>"] = function ()
            M.action = "sp "
            return "<RIGHT>"
        end,
        ["<C-l>"] = function ()
            M.action = "tabedit "
            return "<RIGHT>"
        end,
    }

    M.bufnr = api.nvim_create_buf(false, true)
    M.winnr = utils.open_win_float(M.bufnr, { border = "single" })

    vim.fn.termopen (
        "rg --files --ignore-vcs --hidden 2> /dev/null " .. dir ..
        "| fzf --preview 'highlight -O ansi {} 2> /dev/null' --preview-window 'right,border-left,nowrap,nofollow,nocycle,' > /tmp/nvim-vifm",
        { on_exit = open_file }
    )
    api.nvim_command "startinsert"

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

api.nvim_create_user_command("FZF", FZF, {
    nargs = "?",
    complete = "dir",
})

-- TODO: First Open
-- M.bufnr = api.nvim_create_buf(false, true)
-- vim.fn.termopen("vifm " .. dir .. " --choose-files /tmp/nvim-vifm", { on_exit = open_file })

-- local function TERMINAL ()
--
--     M.bufnr = api.nvim_create_buf(false, true)
--     M.winnr = utils.open_win_float(M.bufnr, {})
--
--     api.nvim_command "startinsert"
--     local cmd = [[
--         function nvim
--             echo $argv > /tmp/nvim-vifm
--             exit
--         end
--     ]]
--     vim.fn.termopen("fish -C '" .. cmd .. "'", { on_exit = open_file })
--
--     vim.keymap.set("t", "<ESC>", "<CMD>quit<CR>", { buffer = true })
--     api.nvim_buf_set_name(M.bufnr, "TERMINAL")
-- end

vim.keymap.set("n", ";e", VIFM, { silent = true })
vim.keymap.set("n", "<C-e>", VIFM, { silent = true })
vim.keymap.set("n", "<C-f>", FZF, { silent = true })

-- vim.keymap.set("n", ";d", TERMINAL, { silent = true })

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



return M

