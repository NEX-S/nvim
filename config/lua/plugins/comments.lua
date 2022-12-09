local api = vim.api

local cms_tbl = {
    lua  = "--",
    c    = "//",
    fish = "#",
}

local cms_blk = {
    lua = { "--[[ ", " ]]", },
    c   = { "/* ", " */", },
}

local reg_tbl = {
    lua  = "%-%-",
    c    = "//",
    fish = "#",
}

local set_text = api.nvim_buf_set_text
local set_line = api.nvim_buf_set_lines

local function line_comment ()

    local cms     = cms_tbl[vim.bo.ft]
    local cms_reg = reg_tbl[vim.bo.ft]

    local str = api.nvim_get_current_line()
    local pos = str:find("%g")
    local row = api.nvim_win_get_cursor(0)[1] - 1

    if str:gsub("^%s*", '') == "" then
        -- api.nvim_buf_set_text(0, row, 0, row, 0, { cms .. " " })
        -- api.nvim_win_set_cursor(0, { row + 1, #cms + 2 })
        vim.cmd("normal!S" .. cms .. "  ")
        vim.cmd "startinsert"
    elseif str:match("^%s*(" .. cms_reg .. ")") == cms then
        str = str:gsub(cms_reg .. "%s?", '', 1)
        set_line(0, row, row + 1, false, { str })
    else
        set_text(0, row, pos - 1, row, pos - 1, { cms .. " " })
    end
end

local function visual_comment ()

    local cms     = cms_tbl[vim.bo.ft]
    local cms_reg = reg_tbl[vim.bo.ft]

    local s_line = vim.fn.getpos("v")[2]
    local e_line = api.nvim_win_get_cursor(0)[1]

    if s_line > e_line then
        s_line, e_line = e_line, s_line
    end

    local line_tbl = api.nvim_buf_get_lines(0, s_line-1, e_line, false)

    local cms_cnt = 0
    local chr_col = 0
    local min_spc = math.huge

    local line_str = nil
    -- GET SELECTED INFO --
    for i = 1, #line_tbl do
        line_str = line_tbl[i]
        if line_str ~= "" then

            chr_col = line_str:find("%g") or min_spc
            min_spc = min_spc < chr_col and min_spc or chr_col

            if line_str:match("^%s*(" .. cms_reg .. ")") == cms then
                cms_cnt = cms_cnt + 1
            end
        end
    end

    -- COMMENTED --
    if cms_cnt == e_line - s_line + 1 then
        for i = 1, #line_tbl do
            line_str = line_tbl[i]:gsub(cms_reg .. "%s?", '', 1)
            set_line(0, s_line + i - 2, s_line + i - 1, false, { line_str })
        end
    else
        local prefix = string.rep(' ', min_spc - 1) .. cms .. " "
        for i = 1, #line_tbl do
            line_str = line_tbl[i]
            line_str = line_str == "" and prefix or prefix .. line_str:sub(min_spc)
            set_line(0, s_line + i - 2, s_line + i - 1, false, { line_str })
        end
    end
end

vim.keymap.set("n", ";c", line_comment, { silent = false })
vim.keymap.set("v", ";c", visual_comment, { silent = false })

vim.keymap.set("n", ";b", function ()
    local cms = cms_blk[vim.bo.ft]

    local res = api.nvim_get_current_line() == "" and "S" or "i"
    return res .. cms[1] .. cms[2] .. string.rep("<LEFT>", #cms[2])
end, { expr = true })
