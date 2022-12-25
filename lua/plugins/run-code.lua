
local api = vim.api
local keymap = vim.keymap.set

local utils = require "utils"

local term = require "plugins.terminal"

local ft_cmd = {
    c      = [[ cd $fileDir && clang -Wall $fileName -o ./bin/$fileNoExt && bash -c 'echo;echo  ; time ./bin/$fileNoExt' ]],
    bash   = [[ cd $fileDir && chmod +x $fileName && bash -c "echo;echo  ; time ./$fileName" ]],
    -- lua    = [[ cd $fileDir && lua $fileName ]],
    php    = [[ cd $fileDir && php $fileName && php -S 127.0.0.1:4444 ]],
    python = [[ cd $fileDir && python -u $fileName ]],
    markdown = [[ cd $fileDir && glow $fileName ]],
}

local function run_cmd (args_table)

    api.nvim_command "silent write!"

    local ft = args_table.args

    if args == nil then
        ft = vim.bo.ft
    end

    local cmd = utils.file_sub(ft_cmd[ft])

    term.open_term_float(cmd, { start_ins = true, exit_key = "<ESC>", resume = false }, { title = " [ RUN CODE ] ", title_pos = "right" })
end

api.nvim_create_user_command("R", run_cmd, {
    nargs = "?",
    complete = function ()
        return { "c", "lua", "python", "php", "html", }
    end,
})
