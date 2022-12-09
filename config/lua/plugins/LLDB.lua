
local api = vim.api

local utils = require "utils"

function CHECK_ASM ()
    vim.cmd "silent write!"

    local expand = vim.fn.expand
    local fileName      = expand("%:t")
    local fileNameNoExt = expand("%:r")

    local handle = nil
    handle = vim.loop.spawn("clang", {
            args = { fileName, "-std=gnu2x", "-g", "-S", "-o", "./bin/" .. fileNameNoExt .. ".asm" },
        },
        vim.schedule_wrap (
            function ()
                handle:close()
                vim.cmd("vsplit ./bin/" .. fileNameNoExt .. ".asm || vert resize 60")
            end
        )
    )

end

function LLDB_DEBUG ()

    local term  = require "plugins.terminal"

    vim.cmd "silent write!"

    local expand = vim.fn.expand
    local fileName      = expand("%:t")
    local fileNameNoExt = expand("%:r")

    local handle = nil
    handle = vim.loop.spawn("clang", {
            args = { fileName, "-std=gnu2x", "-g", "-o", "./bin/" .. fileNameNoExt },
        },
        vim.schedule_wrap (
            function ()
                handle:close()
                term.open_term_vert("lldb ./bin/" ..fileNameNoExt, { vert_size = 60, start_ins = true, exit_key = ";q" })
            end
        )
    )

end

api.nvim_create_user_command("ASM", CHECK_ASM, {})
api.nvim_create_user_command("LLDB", LLDB_DEBUG, {})
