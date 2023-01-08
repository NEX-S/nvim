
local api = vim.api

local utils = require "utils"

local test = [[
    It seems I do understand your attitude somewhat, anyway, because I go through a similar process every so often.
    I have an “Agonizing Reappraisal” of my work and change everything as much as possible and hate everything
    I’ve done, and try to do something entirely different and better.

    Maybe that kind of process is necessary to me, pushing me on and on.
    The feeling that I can do better than that shit I just did.
    Maybe you need your agony to accomplish what you do.
    And maybe it goads you on to do better. But it is very painful I know.
]]

local function get_res (str)
    local method    = "-X POST "
    local deepl_api = "-s 'https://api-free.deepl.com/v2/translate' "
    local auth_key  = "-H 'Authorization: DeepL-Auth-Key 5b572043-9d05-0b9c-ace0-48acc8e38e0c:fx' "
    local content   = "-d 'target_lang=ZH&text=" .. str .. "'"

    local curl_req = "curl " .. method .. deepl_api .. auth_key .. content

    local data = vim.fn.system(curl_req)

    return vim.json.decode(data).translations[1].text
end


vim.keymap.set("x", ",t", function ()
    local tbl = utils.get_visual_select()
    local str = table.concat(tbl, "////\n")

    str = get_res(str)

    local sline = vim.fn.getpos("v")[2] - 1
    local ns_id = api.nvim_create_namespace("TransVirt")

    for line in string.gmatch(str, "[^(////)]+") do

        local virt_opts = {
            id = sline,
            virt_text_pos = "eol",
            virt_text = {
                { "  " .. line, "TranslateVirt" },
            },
        }

        local line_str = api.nvim_buf_get_lines(0, sline, sline + 1, false)[1]

        -- if line_str == "" or line_str:match("[^%.]$") then
        if line_str == "" then
            sline = sline + 1
        end

        api.nvim_buf_set_extmark(0, ns_id, sline, 0, virt_opts)

        sline = sline + 1
    end
end)
