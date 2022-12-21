
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

local api = vim.api

local fold_opts = {
    foldenable   = false,

    foldlevel    = 10,
    foldnestmax  = 10,
    foldminlines = 4,

    foldmethod   = "indent",
    foldtext     = "v:lua._fold_text()",
}

require "core.options".set_opts(fold_opts)

function _G._fold_text ()
    local fold_spos = vim.v.foldstart
    -- local s_str = vim.fn.getline(fold_spos)
    local s_str = api.nvim_buf_get_lines(0, fold_spos - 1, fold_spos, true)[1]

    -- local fold_epos = vim.v.foldend
    -- local e_str = vim.fn.getline(fold_spos)
    -- local line_cnt = fold_epos - fold_spos

    local fold_indent = s_str:find("%w") - 1

    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. "  " .. string.rep(" ", 1000)
    return string.rep(" ", fold_indent - 1) .. " " .. s_str:gsub("^%s*", "") .. " //// " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 3) .. "  " .. s_str:gsub("^%s*", "") .. "  " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. "  " .. s_str:gsub("^%s*", "") .. "  " .. string.rep(" ", 1000)
    -- return s_str .. " //// " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " +" .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. "+ " .. s_str:gsub("^%s*", "") .. " " .. string.rep(" ", 1000)

    -- return string.rep(" ", fold_indent - 3) .. " " ..  s_str:gsub("^%s*", "") .. " " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 3) .. "  " ..  s_str:gsub("^%s*", "") .. " " .. string.rep(" ", 1000)
end
