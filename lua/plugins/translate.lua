
local api  = vim.api
local loop = vim.loop

local utils = require "utils"

local function trans_line (visual_tbl)
    local sline = vim.fn.getpos("v")[2] - 2

    local line_str = ""
    local line_res = ""
    local virt_opt = {}

    local ns_id = api.nvim_create_namespace("VirtualTranslate")

    for i = 1, #visual_tbl do
        line_str = visual_tbl[i]
        if line_str ~= "" then
            local handle = nil
            local stdout = loop.new_pipe(false)
            handle = loop.spawn("curl", {
                args = {
                    "-s", "-X", "POST", "https://api-free.deepl.com/v2/translate",
                    "-H", "Authorization: DeepL-Auth-Key 5b572043-9d05-0b9c-ace0-48acc8e38e0c:fx",
                    "-d", "target_lang=ZH&text=" .. line_str,
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

                        local virt_opts = {
                            id = sline + i,
                            virt_text_pos = "eol",
                            virt_text = {
                                { "  " .. res:gsub("^%s+", ''), "TranslateVirt" },
                            },
                        }

                        api.nvim_buf_set_extmark(0, ns_id, sline + i, 0, virt_opts)
                    end
                end)
            )
        end
    end
end

local function trans_content (visual_content)
    local sline = vim.fn.getpos("v")[2] - 1

    local ns_id = api.nvim_create_namespace("VirtualTranslate")

    local handle = nil
    local stdout = loop.new_pipe(false)
    handle = loop.spawn("curl", {
        args = {
            "-s", "-X", "POST", "https://api-free.deepl.com/v2/translate",
            "-H", "Authorization: DeepL-Auth-Key 5b572043-9d05-0b9c-ace0-48acc8e38e0c:fx",
            "-d", "target_lang=ZH&text=" .. visual_content,
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

                for line_res in res:gmatch("[^(%s%s%s)]+") do

                    if api.nvim_buf_get_lines(0, sline, sline + 1, false)[1] == "" then
                        sline = sline + 1
                    end

                    local virt_opts = {
                        id = sline,
                        virt_text_pos = "eol",
                        virt_text = {
                            { "  " .. line_res:gsub("^%s+", ''), "TranslateVirt" },
                        },
                    }

                    api.nvim_buf_set_extmark(0, ns_id, sline, 0, virt_opts)
                    sline = sline + 1
                end
            end
        end)
    )
end

vim.keymap.set("x", ",t", function ()
    local visual_tbl = utils.get_visual_select()

    if api.nvim_get_mode().mode == "V" then
        trans_line(visual_tbl)
    else
        local visual_content = table.concat(visual_tbl, "\n")
        trans_content(visual_content)
    end
end)

local term = require "plugins.terminal"
vim.keymap.set("n", ",t", function ()
    local cword = vim.fn.expand("<cword>")

    local term_opts = {
        vert_size = 40,
        start_ins = false,
        exit_key  = "<ESC>",
    }

    term.open_term_vert("trans -s en -to zh -j -speak -indent 2 '" .. cword .. "'", term_opts)
end)

--     It seems I do understand your attitude somewhat, anyway, because I go through a similar process every so often.
--     I have an “Agonizing Reappraisal” of my work and change everything as much as possible and hate everything
--     I’ve done, and try to do something entirely different and better.
-- 
--     Maybe that kind of process is necessary to me, pushing me on and on.
--     The feeling that I can do better than that shit I just did.
--     Maybe you need your agony to accomplish what you do.
--     And maybe it goads you on to do better. But it is very painful I know.

-- local function get_res (str)
--     local method    = "-X POST "
--     local deepl_api = "-s 'https://api-free.deepl.com/v2/translate' "
--     local auth_key  = "-H 'Authorization: DeepL-Auth-Key 5b572043-9d05-0b9c-ace0-48acc8e38e0c:fx' "
--     local content   = "-d 'target_lang=ZH&text=" .. str .. "'"
-- 
--     local curl_req = "curl " .. method .. deepl_api .. auth_key .. content
-- 
--     local data = vim.fn.system(curl_req)
-- 
--     return vim.json.decode(data).translations[1].text
-- end

