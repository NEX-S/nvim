
vim.keymap.set("n", "/", ":", { remap = false, silent = false })

local api = vim.api

local M = {}

local function open_float_cmdline (opts)

    local nvim_width  = api.nvim_get_option("columns")
    local float_width = math.ceil(nvim_width  * 0.4)
    local float_colmn = math.ceil((nvim_width  - float_width)  * 0.5)

    local win_opts = {
        row       = 2,
        col       = float_colmn,
        width     = float_width,
        height    = 1,
        noautocmd = true,
        relative  = "editor",
        style     = "minimal",
        border    = opts.border,
        title     = opts.title,
        title_pos = opts.title_pos,
    }

    M.bufnr = api.nvim_create_buf(false, true)
    M.winid = api.nvim_open_win(M.bufnr, true, win_opts)

    api.nvim_win_set_option(M.winid, "winblend", opts.blend or 25)
    api.nvim_win_set_option(M.winid, "winhl", "Normal:CmdlineNormal")
end

local function close_float_cmdline ()
    api.nvim_win_close(M.winid, true)
    api.nvim_buf_delete(M.bufnr, { force = true })

    api.nvim_win_set_cursor(0, M.cursor_pos)
end

local function prompt_callback (text)
    -- api.nvim_win_hide(M.winid)
    close_float_cmdline()
    if text:match("q") then
        api.nvim_command("silent!" .. text)
    else
        api.nvim_command(text)
    end
end

function _G._cmdline_complete (findstart, base)
    if findstart == 1 then
        local col = api.nvim_win_get_cursor(0)[2]
        local str = api.nvim_get_current_line():sub(1, col - 1)
        local _, res = str:find(".*%s")
        return res
    else
        local dict_src = {
            ["cmdline"]    =  "  [CMDLINE]",
            ["function"]   =  "  [FUNCTION]",
            ["help"]       =  "  [HELP]",
            ["option"]     =  "  [OPTION]",
            ["event"]      =  "  [EVENT]",
            ["highlight"]  =  "  [HIGHLIGHT]",
        }

        for src, kind in pairs(dict_src) do
            local src_dict = vim.fn.getcompletion(base, src)
            for i = 1, #src_dict do
                vim.fn.complete_add({ word = src_dict[i], kind = kind })
            end
        end
    end
end

vim.keymap.set("n", ":", function ()

    M.cursor_pos = api.nvim_win_get_cursor(0)

    if api.nvim_buf_get_option(0, "modifiable") == true then
        api.nvim_command [[ keeppatterns %s/\s\+$//e ]]

        local n_lines = api.nvim_buf_line_count(0)
        local last_nonblank = vim.fn.prevnonblank(n_lines)
        if last_nonblank < n_lines then
            api.nvim_buf_set_lines(0, last_nonblank, n_lines - 1, true, {})
        end
    end

    -- open_float_cmdline({
    --     border = "single", title = " [ CMDLINE ] ", title_pos = "right"
    -- })
    open_float_cmdline({
        border = "none"
    })
    api.nvim_command "startinsert"
    vim.bo.ft = "CMDLINE"
    api.nvim_buf_set_option(M.bufnr, "buftype", "prompt")
    vim.fn.prompt_setprompt(M.bufnr, "  ")
    vim.fn.prompt_setcallback(M.bufnr, prompt_callback)

    vim.bo.omnifunc = "v:lua._cmdline_complete"

    vim.keymap.set("i", "<ESC>", function ()
        if vim.fn.pumvisible() == 1 then
            api.nvim_input("<C-u>")
        end
        close_float_cmdline()
    end, { buffer = true })

    local cmdline_keymap = {
        ["<TAB>"] = function ()
            return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-x><C-o>"
        end,
        ["<CR>"] = function ()
            return vim.fn.pumvisible() == 1 and "<C-x><CR>" or "<CR>"
        end,
    }

    for lhs, rhs in pairs(cmdline_keymap) do
        vim.keymap.set("i", lhs, rhs, { buffer = true, expr = true })
    end
end)

