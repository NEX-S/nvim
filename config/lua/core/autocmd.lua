
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

-- RESUME CURSOR
api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function ()
        local fn = vim.fn
        if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
            fn.setpos(".", fn.getpos("'\""))
            -- vim.cmd("silent! foldopen")
        end
    end,
})

-- AUTO TRIM SPACES TODO
api.nvim_create_autocmd("CmdlineEnter", {
    pattern = "*",
    command = [[silent! keeppatterns %s/\s\+$//e | retab | set hlsearch ]],
})

-- api.nvim_create_autocmd("CmdlineEnter", {
--     command = "set hlsearch"
-- })

-- api.nvim_create_autocmd("CmdlineLeave", {
--     command = "set nohlsearch"
-- })

