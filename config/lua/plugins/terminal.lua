
local api = vim.api


local utils = require "utils"

local M = {}

-- TODO: tabnew vim split vsp ...

-- VERT TERM --
function M.open_term_vert (shell_cmd, opts)
    api.nvim_command("vs term://" .. shell_cmd)
    api.nvim_command("vert resize " .. opts.vert_size .. " || set nonu")

    if opts.start_ins == true then
        api.nvim_command "startinsert"
    end

    vim.keymap.set("n", opts.exit_key, "<CMD>quit!<CR>", { buffer = true })
end

local function win_cmd_exec (cmd, opts)

    bufnr = api.nvim_create_buf(true, true)
    winid = utils.open_win_float(bufnr, opts)

    -- vim.fn.termopen(cmd or os.getenv("SHELL"))
    vim.fn.termopen(cmd, { on_exit = opts.on_exit or function () end })

    return winid, bufnr
end

-- FLOAT TERM --
M.open_term_tbl = {}
function M.open_term_float (shell_cmd, opts, ...)

    local args  = ...

    local winid = nil
    local bufnr = nil

    -- local virt_bufnr = vim.fn.bufnr("%")
    -- local virt_ns_id = utils.set_virt_buf("float_term_virt", "┃ UNEXPECTED ┃", {
    --         line = vim.fn.getpos("w0")[2] + 2, col = 27, pos = "overlay", hl_group = "FloatTitle"
    --     }
    -- )

    -- resume = true
    if opts.resume == true then

        local term_name = opts.term_name
        local bufnr = M.open_term_tbl[term_name]

        -- term first open
        if bufnr == nil then
            winid, bufnr = win_cmd_exec(shell_cmd, args)
            M.open_term_tbl[term_name] = bufnr
        -- resume term
        elseif api.nvim_buf_is_valid(bufnr) then
            winid = utils.open_win_float(bufnr, args)
        -- quit! handle
        else
            print("[ WARN ] ACTIVATE A UN-HIDE TERM")
            winid, bufnr = win_cmd_exec(shell_cmd, args)
        end
    -- resume = false
    else
        winid, bufnr = win_cmd_exec(shell_cmd, args)
    end

    if opts.start_ins == true then
        api.nvim_command "startinsert"
    end

    vim.keymap.set({ "t", "n" }, opts.exit_key, function ()
        api.nvim_win_hide(winid)
        if opts.resume == false then
            api.nvim_buf_delete(bufnr, { force = true })
        end
    end, { buffer = true })

    -- vim.keymap.set("n", ";q", function ()
    --     api.nvim_win_hide(winid)
    --     if opts.resume == false then
    --         api.nvim_buf_delete(bufnr, { force = true })
    --     end
    -- end, { buffer = true })

    vim.bo.ft = "TERMINAL"
    api.nvim_buf_set_name(0, "  TERMINAL")
end

return M

