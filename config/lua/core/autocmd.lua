
local api = vim.api

-- AUTO SOURCE --
-- api.nvim_create_autocmd("BufWritePost", {
--     pattern = "init.lua",
--     command = "source %",
-- })

-- AUTO CURSORLINE
vim.defer_fn(function ()
    vim.api.nvim_create_autocmd("InsertEnter", {
        pattern = "*",
        command = "set nocursorline"
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        command = "set cursorline"
    })
end, 200)

-- vim.api.nvim_create_autocmd("VimLeave", {
--     -- pattern = "*",
--     command = "!rm /tmp/nvim_time.log"
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
        vim.cmd [[ keeppatterns %s/\s\+$//e | set hlsearch ]]
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
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function ()
        local fn = vim.fn
        if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
            fn.setpos(".", fn.getpos("'\""))
        end
    end,
})
