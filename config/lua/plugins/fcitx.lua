
local api  = vim.api
local loop = vim.loop

-- Switch input method --

local fcitx_status = 0
api.nvim_create_autocmd({ "InsertEnter", "FocusLost" }, {
    pattern = "*",
    callback = function ()
        if fcitx_status == 2 then
            local handle = nil
            handle = loop.spawn("fcitx5-remote", {
                    args = { "-o", },
                },
                function ()
                    handle:close()
                end
            )
        end
    end
})

api.nvim_create_autocmd({ "InsertLeave", "FocusGained" }, {
    pattern = "*",
    callback = function ()
        local stdout = loop.new_pipe()
        local handle = nil
        handle = loop.spawn("fcitx5-remote", {
            stdio = { nil, stdout, nil },
        },
        function ()
            stdout:read_stop()
            stdout:close()
            handle:close()
        end
        )

        loop.read_start(stdout, vim.schedule_wrap (
            function (err, data)
                if data ~= nil then
                    fcitx_status = tonumber(data)
                    if fcitx_status == 2 then
                        local handle = nil
                        handle = loop.spawn("fcitx5-remote", {
                                args = { "-c", }, -- -e
                            },
                            function ()
                                handle:close()
                            end
                        )
                    end
                end
            end)
        )
    end
})
