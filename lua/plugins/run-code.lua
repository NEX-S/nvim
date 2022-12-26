
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
    lua    = function ()
        api.nvim_command("source %")
    end,
    html = function ()
        local file = api.nvim_buf_get_name(0)
        os.execute("cp ".. file .. " /tmp/live-server.html")

        api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "WinEnter" }, {
            pattern = "*.html",
            callback = function ()
                vim.schedule(function ()
                    -- local cline = api.nvim_win_get_cursor(0)[1]
                    -- local lines = api.nvim_buf_get_lines(0, cline - 100, cline + 100, false)

                    -- local cline = api.nvim_win_get_cursor(0)[1]
                    local lines = api.nvim_buf_get_lines(0, 0, -1, false)
                    table.insert(lines, 1, "<head><meta charset='UTF-8'></head>")

                    local tfile = io.open("/tmp/live-server.html", "w")
                    for i = 1, #lines do
                        tfile:write(lines[i] .. "\n")
                    end

                    tfile:close()
                end)
            end
        })

        vim.loop.new_thread(function (file)
            os.execute("live-server --wait=0 --quiet /tmp/live-server.html")
        end)
    end
}

local function run_cmd (args_table)

    api.nvim_command "silent write!"

    local ft = args_table.args

    if args == nil then
        ft = vim.bo.ft
    end

    local cmd = ft_cmd[ft]

    if type(cmd) == "function" then
        cmd()
    else
        term.open_term_float(utils.file_sub(cmd), { start_ins = true, exit_key = "<ESC>", resume = false }, { title = " [ RUN CODE ] ", title_pos = "right" })
    end

end

api.nvim_create_user_command("R", run_cmd, {
    nargs = "?",
    complete = function ()
        return { "c", "lua", "python", "php", "html", }
    end,
})
