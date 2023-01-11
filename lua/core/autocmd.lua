
local api = vim.api

-- AUTO SOURCE --
-- api.nvim_create_autocmd("BufWritePost", {
--     pattern = "init.lua",
--     command = "source %",
-- })

-- api.nvim_create_autocmd ({ "FocusGained", "TermClose", "TermLeave" }, {
--     command = "checktime"
-- })

-- BufReadPost 
-- api.nvim_create_autocmd( "BufWinEnter", {
--     callback = function()
--         local mark = api.nvim_buf_get_mark(0, '"')
--         local line = api.nvim_buf_line_count(0)
--         if mark[1] > 0 and mark[1] <= line then
--             pcall(api.nvim_win_set_cursor, 0, mark)
--         end
--     end,
-- })

-- TODO: enable spell in markdown file

-- AUTO CURSORLINE
vim.defer_fn(function ()
    api.nvim_create_autocmd("InsertEnter", {
        pattern = "*",
        command = "set nocursorline"
    })

    api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        command = "set cursorline"
    })
end, 200)

-- api.nvim_create_autocmd("VimLeave", {
--     -- pattern = "*",
--     command = "!rm /tmp/nvim_time.log"
-- })

-- api.nvim_create_autocmd("CmdlineEnter", {
--     pattern = { "/", "?" },
--     command = "set hlsearch",
-- })

-- AUTO TRIM SPACES TODO
api.nvim_create_autocmd("CmdlineEnter", {
    pattern = ":",
    callback = function ()

        -- BAD PERFORMANCE
        -- local line_tbl = api.nvim_buf_get_lines(0, 1, -1, false)
        -- for i = 1, #line_tbl do
        --     local new_line = line_tbl[i]:gsub("%s*$", '')
        --     api.nvim_buf_set_lines(0, i, i+1, false, { new_line })
        -- end

        -- let v = winsaveview()
        -- keeppatterns %s/\s\+$//e
        -- call winrestview(v)

        -- PLUGIN cmdline also trim too (checkit out!) :)
        local cursor_pos = api.nvim_win_get_cursor(0)
        -- retab ?
        pcall(api.nvim_command, [[ keeppatterns %s/\s\+$//e ]])
        api.nvim_win_set_cursor(0, cursor_pos)

        local n_lines = api.nvim_buf_line_count(0)
        local last_nonblank = vim.fn.prevnonblank(n_lines)
        if last_nonblank < n_lines then
            api.nvim_buf_set_lines(0, last_nonblank, n_lines - 1, true, {})
        end
    end
})

-- api.nvim_create_autocmd("CmdlineEnter", {
--     command = "set hlsearch"
-- })

-- api.nvim_create_autocmd("CmdlineLeave", {
--     command = "set nohlsearch"
-- })

-- RESUME CURSOR
-- api.nvim_create_autocmd("BufWinEnter", {
--     pattern = "*",
--     command = "normal! g`\""
--     -- command = [[
--     --     execute "normal! g`\""
--     -- ]]
--     -- callback = function ()
--     --     local cursor_pos = api.nvim_buf_get_mark(0, [["]])
--     --     api.nvim_win_set_cursor(0, cursor_pos)
--     --     -- local fn = vim.fn
--     --     -- if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
--     --     --     fn.setpos(".", fn.getpos("'\""))
--     --     -- end
--     -- end,
-- })

-- api.nvim_command "cabbrev S source %"
api.nvim_command "cabbrev H tab help"

-- api.nvim_create_autocmd("FileType", {
--     pattern = "help",
--     command = "wincmd L"
-- })

api.nvim_create_autocmd( "BufWinEnter", {
    command = "silent! loadview"
})

api.nvim_create_autocmd( "BufWinLeave", {
    command = "silent! mkview"
})
