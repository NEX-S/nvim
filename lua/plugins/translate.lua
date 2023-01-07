
local api = vim.api

local loop = vim.loop
local utils = require "utils"

vim.keymap.set("x", ",t", function ()
    local res_tbl = {}

    local visual_tbl = utils.get_visual_select()

    local sline = vim.fn.getpos("v")[2]
    local eline = vim.fn.getpos(".")[2]
    -- local ns_id = api.nvim_create_namespace("TranslateVirt")

    for i = 1, #visual_tbl do
        local handle = nil
        local stdout = loop.new_pipe(false)
        handle = loop.spawn("curl", {
                args = {
                    "-s", "-X", "POST", "https://api-free.deepl.com/v2/translate",
                    "-H", "Authorization: DeepL-Auth-Key 5b572043-9d05-0b9c-ace0-48acc8e38e0c:fx",
                    "-d", "target_lang=ZH&text=" .. visual_tbl[i],
                },
                stdio = { nil, stdout, nil },
            },
            function()
                stdout:read_stop()
                stdout:close()
                handle:close()
            end
        )

        loop.read_start(stdout, vim.schedule_wrap (
            function (err, data)
                if data ~= nil then
                    local res = vim.json.decode(data).translations[1].text
                    -- table.insert(res_tbl, res)

                    local virt_opts = {
                        id = 1,
                        virt_text_pos = "eol",
                        virt_text = {
                            { "   " .. res:gsub("^%s+", ''), "TranslateVirt" },
                        },
                    }

                    local ns_id = api.nvim_create_namespace("")

                    api.nvim_buf_set_extmark(0, ns_id, sline + i - 2, 0, virt_opts)
                end
            end)
        )
    end

end)
