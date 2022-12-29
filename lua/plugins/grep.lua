
local api  = vim.api
local loop = vim.loop

local utils = require "utils"

api.nvim_create_autocmd("Filetype", {
    pattern = "quickfix",
    callback = function ()
        local quickfix = {
            ["j"]  = "<CMD>silent! lnext      | wincmd w<CR>",
            ["k"]  = "<CMD>silent! lprevious  | wincmd w<CR>",
            ["J"]  = "<CMD>silent! 5lnext     | wincmd w<CR>",
            ["K"]  = "<CMD>silent! 5lprevious | wincmd w<CR>",
            ["G"]  = "<CMD>silent! llast      | wincmd w<CR>",
            ["gg"] = "<CMD>silent! lfirst     | wincmd w<CR>",

            ["l"] = "<C-w><C-w>",
            ["o"] = "<C-w><C-w>",
            ["q"] = "<CMD>lclose<CR>",
            ["<ESC>"] = "<CMD>lclose<CR>",
        }

        for lhs, rhs in pairs(quickfix) do
            api.nvim_buf_set_keymap(0, "n", lhs, rhs, { noremap = true })
        end
    end
})

function asyncGrep (str)
    local results = {}
    local stdout = loop.new_pipe(false)
    local handle = nil
    handle = loop.spawn('rg', {
            args = { '--vimgrep', '--smart-case', str },
            stdio = { nil, stdout, nil }
    },
        vim.schedule_wrap(function ()
            stdout:read_stop()
            stdout:close()
            handle:close()
            if #results > 1 then
                api.nvim_command("tabnew")
                vim.fn.setloclist(0, {}, 'r', { title = 'RG RESULTS', lines = results })
                api.nvim_command [[
                    lwindow  | lfirst
                    wincmd w | wincmd H
                    vert resize 30
                    set filetype=quickfix
                ]]
                -- api.nvim_command("Trouble loclist")
                api.nvim_set_option_value("number", false, {})
                api.nvim_buf_set_name(0, "RG: " .. str)
            else
                print(" RG NOT FOUND: " .. str)
            end
        end)
    )
    loop.read_start(stdout, function (err, data)
        if data ~= nil then
            table.insert(results, data)
        end
    end)
end

vim.keymap.set("x", ";g", function ()
    local str = utils.get_visual_select()[1]
    asyncGrep(str)
end)
