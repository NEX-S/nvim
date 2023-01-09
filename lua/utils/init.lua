local api = vim.api

local M = {}

function M.get_cursor_content (left_index, right_index)
    local cursor_line = api.nvim_get_current_line()
    local cursor_colm = api.nvim_win_get_cursor(0)[2]
    return cursor_line:sub(cursor_colm + left_index, cursor_colm + right_index)
end

function M.get_char_num (str, char, pos)
    pos = pos or 0
    if str ~= "" or char ~= nil or char ~= "" then
        str = str:sub(pos)
        return #str:gsub("[^" .. char .. "]", '')
    end
end

function M.file_sub (str)

    if str == "" or str == nil then
        print("utils.file_sub: str is NULL")
        return nil
    end

    local sub_map = {
        ["$filePath"]  = vim.fn.expand("%:p"),
        ["$fileExt"]   = vim.fn.expand("%:e"),
        ["$fileDir"]   = vim.fn.expand("%:p:h"),
        ["$fileName"]  = vim.fn.expand("%:t"),
        ["$fileNoExt"] = vim.fn.expand("%:r"),
    }

    for key, value in pairs(sub_map) do
        str = str:gsub(key, value)
    end

    return str
end

function M.open_win_float (bufnr, opts)

    local opts = opts or {}

    -- Get dimensions
    local width  = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")

    -- Calculate floating window size
    local win_width  = math.ceil(width  * 0.7)
    local win_height = math.ceil(height * 0.7)

    -- Calculate floating term starting position
    local col = math.ceil((width  - win_width)  * 0.5)
    local row = math.ceil((height - win_height) * 0.4)

    local win_opts = {
        row       = row,
        col       = col,
        width     = win_width,
        height    = win_height,
        relative  = "editor",
        style     = "minimal",
        border    = opts.border or "single",
        title     = opts.title,
        title_pos = opts.title_pos,
    }

    local winid = api.nvim_open_win(bufnr, true, win_opts)

    api.nvim_win_set_option(winid, "winhl", "Normal:FloatTermNormal")
    api.nvim_win_set_option(winid, "winblend", opts.win_blend or 25)

    return winid
end

function M.set_virt_buf (bufnr, ns, virt_str, virt_opts)

    local bufnr = bufnr
    local ns_id = api.nvim_create_namespace(ns)

    local opts = {
        id = 1,
        virt_text = { { virt_str, virt_opts.hl_group }, },
        virt_text_pos = virt_opts.pos,
    }

    api.nvim_buf_set_extmark(bufnr, ns_id, virt_opts.line, virt_opts.col or 0, opts)

    return ns_id
end

function M.get_visual_select ()

    local spos = vim.fn.getpos("v")
    local epos = vim.fn.getpos(".")

    if epos[2] < spos[2] then
        spos, epos = epos, spos
    end

    local mode = api.nvim_get_mode().mode
    if mode == "v" then
        return api.nvim_buf_get_text(0, spos[2] - 1, spos[3] - 1, epos[2] - 1, epos[3], {})
    elseif mode == "V" then
        return api.nvim_buf_get_lines(0, spos[2] - 1, epos[2], false)
    end
end

return M
