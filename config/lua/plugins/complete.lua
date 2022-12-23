local api = vim.api
local opt = vim.opt

local utils = require "utils"

opt.infercase   = true
opt.complete    = ".,w,b,k"
opt.completeopt = "menu,menuone,noselect"

local key_str = "A-B-C-D-E-F-G-H-I-J-K-L-M-N-O-P-Q-R-S-T-U-V-W-X-Y-Z-a-b-c-d-e-f-g-h-i-j-k-l-m-n-o-p-q-r-s-t-u-v-w-x-y-z-0-1-2-3-4-5-6-7-8-9-#"
for key in string.gmatch(key_str, "[^-]") do
    vim.keymap.set("i", key, function ()
        return vim.fn.pumvisible() == 0 and key .. "<C-n>" or key
    end, { expr = true })
end

local special_map = {
    ["<TAB>"] = function ()
        local cursor_left = utils.get_cursor_content(0, 0)

        if vim.fn.pumvisible() == 1 then
            return "<C-n>"
        elseif cursor_left == "" or cursor_left == " " then
            return "<TAB>"
        elseif cursor_left == "/" then
            return "<C-x><C-f>"
        end

        return "<C-x><C-u>"
    end,
    ["<CR>"] = function ()
        return vim.fn.pumvisible() == 0 and "<CR>" or "<C-x><CR>"
    end,
    ["/"] = function ()
        return "/<C-x><C-f>"
    end,
}

for lhs, rhs in pairs(special_map) do
    vim.keymap.set("i", lhs, rhs, { expr = true })
end

-- api.nvim_create_autocmd("TextChangedI", {
--     pattern = "*",
--     callback = function ()
--         -- vim.schedule(function ()
--             local cursor_left = utils.get_cursor_content(-1, -1)
--             if vim.fn.pumvisible() == 0 and cursor_left:match("%a") then
--                 api.nvim_input("<C-x><C-z><C-n>")
--             end
--         -- end)
--     end
-- })
