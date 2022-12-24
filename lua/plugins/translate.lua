
local api = vim.api

local term = require "plugins.terminal"

local M = {}

function M.translate ()

    local get_content_tbl = {
        n = vim.fn.expand("<cword>"),
        v = nil,
        V = api.nvim_get_current_line():gsub("^%s*", '')
    }

    local mode = api.nvim_get_mode().mode
    local content = get_content_tbl[mode]

    local term_opts = {
        vert_size = 40,
        start_ins = false,
        exit_key  = "<ESC>",
    }

    term.open_term_vert("trans -s en -to zh -j -speak -indent 2 '" .. content .. "'", term_opts)
end

return M
