
local api = vim.api
local utils = require "utils"

api.nvim_create_autocmd("Filetype", {
    pattern = "quickfix",
    callback = function ()
        local quickfix = {
            ["j"] = "<CMD>silent! cnext      | wincmd w<CR>",
            ["k"] = "<CMD>silent! cprevious  | wincmd w<CR>",
            ["J"] = "<CMD>silent! 5cnext     | wincmd w<CR>",
            ["K"] = "<CMD>silent! 5cprevious | wincmd w<CR>",

            ["l"] = "<C-w><C-w>",
            ["o"] = "<C-w><C-w>",
            ["q"] = "<CMD>cclose<CR>",
            ["<ESC>"] = "<CMD>cclose<CR>",
        }

        for lhs, rhs in pairs(quickfix) do
            api.nvim_buf_set_keymap(0, "n", lhs, rhs, { noremap = true })
        end
    end
})

vim.keymap.set("x", ";g", function ()
    local str = utils.get_visual_select()[1]
    api.nvim_command("silent! grep! -R " .. vim.fn.shellescape(str) .. " .")
    api.nvim_command("tabnew | copen | cnext | cprevious | wincmd w | wincmd H | vert resize 40")
    api.nvim_command("set ft=quickfix")
    api.nvim_set_option_value("number", false, {})
    api.nvim_buf_set_name(0, "QUICKFIX PREVIEW")
end)
