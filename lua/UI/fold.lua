
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

local api = vim.api

local fold_opts = {
    foldenable   = true,

    foldminlines = 4,
    foldlevel    = 10,
    foldnestmax  = 10,

    foldcolumn   = '1',
    foldmethod   = "indent",
    foldtext     = "v:lua._fold_text()",
}

-- TODO: local listchars = {
--  xxx = xxx
-- }
-- for + opt:append

for key, value in pairs(fold_opts) do
    api.nvim_set_option_value(key, value, {})
end

local ns_id = api.nvim_create_namespace("fold_ns")
vim.keymap.set('n', ' ', function ()

    local sline = vim.v.foldstart
    local eline = vim.v.foldend

    local cline = api.nvim_win_get_cursor(0)[1]

    if sline ~= 0 and cline >= sline and cline <= eline then

        local indents = api.nvim_buf_get_lines(0, sline - 1, sline, true)[1]
        local fillpos = indents:find("[^%s]") - 3

        local opts = {
            id = sline,
            virt_text = { { '', "FoldClose" }, },
            virt_text_pos = "overlay",
        }

        -- if vim.fn.foldclosed(cline) == -1 then
        --     opts = {
        --         id = sline,
        --         virt_text = { { '', "FoldOpen" }, },
        --         virt_text_pos = "overlay",
        --     }
        -- end

        api.nvim_buf_set_extmark(0, ns_id, sline - 1, fillpos, opts)
    end

    api.nvim_command("silent!normal! za")
    api.nvim_command("silent!mkview")
end, { expr = false })

function _G._fold_text ()
    local sline = vim.v.foldstart

    if sline ~= 0 then

        local string = api.nvim_buf_get_lines(0, sline - 1, sline, true)[1]

        local indent = string:find("%S") - 1

        return string.rep(' ', indent - 2) .. " " .. string:gsub("^%s*", '')
    end

    -- local s_str = vim.fn.getline(fold_spos)

    -- local fold_epos = vim.v.foldend
    -- local e_str = vim.fn.getline(fold_spos)
    -- local line_cnt = fold_epos - fold_spos


    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. "  " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " ⁄⁄⁄⁄ " .. string.rep("    ", 100)
    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " ⇂" .. string.rep("    ", 100)
    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " ⇂" .. string.rep("    ", 100)

    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " ⁄⁄⁄⁄ "
    -- return s_str .. " ⁄⁄⁄⁄ "


    -- return string.rep(' ', vim.v.foldlevel * 4 - 2) .. " " .. s_str:gsub("^%s*", '')

    -- return '' .. string.rep(" ", fold_indent - 1) .. s_str:gsub("^%s*", "") .. " ⁄⁄⁄⁄ "
    -- return s_str .. " ⁄⁄⁄⁄ "

    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " ⇂" .. string.rep("    ", 100)
    -- return string.rep(" ", fold_indent - 3) .. "  " .. s_str:gsub("^%s*", "") .. "  " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. "  " .. s_str:gsub("^%s*", "") .. "  " .. string.rep(" ", 1000)
    -- return s_str .. " //// " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. " " .. s_str:gsub("^%s*", "") .. " +" .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 2) .. "+ " .. s_str:gsub("^%s*", "") .. " " .. string.rep(" ", 1000)

    -- return string.rep(" ", fold_indent - 3) .. " " ..  s_str:gsub("^%s*", "") .. " " .. string.rep(" ", 1000)
    -- return string.rep(" ", fold_indent - 3) .. "  " ..  s_str:gsub("^%s*", "") .. " " .. string.rep(" ", 1000)
end

api.nvim_create_autocmd("BufWinEnter", {
    command = "silent! loadview"
})

api.nvim_create_autocmd("BufWinLeave", {
    command = "silent! mkview"
})
