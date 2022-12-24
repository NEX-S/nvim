
local api = vim.api

local loop = vim.loop

local utils = require "utils"

local stdout = loop.new_pipe()
local handle = nil
handle = loop.spawn ("tail", {
        args = { "-n 1", "/tmp/nvim_time.log" },
        stdio = { nil, stdout, nil },
    },
    function ()
        stdout:read_stop()
        stdout:close()
        handle:close()
    end
)

loop.read_start(stdout, vim.schedule_wrap(
    function (err, data)
        if data ~= nil then
            local time_str = data
            local pos = time_str:gsub("[a-zA-Z%-_:\n]", ''):find(" ")

            time_str = " " .. time_str:sub(0, pos) .. "ms  "

            local bufnr = api.nvim_get_current_buf()
            local ns_id = utils.set_virt_buf(bufnr, "start_time", time_str, {
                line = vim.fn.getpos("w0")[2],
                col = 0,
                pos = "right_align",
                hl_group = "StartTime"
            })

            vim.keymap.set("n", "<C-1>", function ()
                local opts = {
                    exit_key = "<ESC>",
                    start_ins = false,
                    resume = false,
                }
                -- local cmd = 'rg "require|buf|lua" /tmp/nvim_time.log | sort -nrk 2'
                -- local cmd = "bat /tmp/nvim_time.log"
                local cmd = "cat /tmp/nvim_time.log"
                require "plugins.terminal".open_term_float(cmd , opts, { title = " [ STARTUP TIME ] ", title_pos = "left" })
            end)

            vim.defer_fn(function ()
                api.nvim_buf_del_extmark(bufnr, ns_id, 1)
                local handle = nil
                handle = loop.spawn ("rm", {
                        args = { "/tmp/nvim_time.log" },
                    },
                    function ()
                        handle:close()
                    end
                )
            end, 3000)
        end
    end)
)
