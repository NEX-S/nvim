
local api = vim.api

local loop = vim.loop
local utils = require "utils"

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

vim.keymap.set("x", ",t", function ()
    local res_tbl = {}

    local visual_tbl = utils.get_visual_select()

    local sline = vim.fn.getpos("v")[2]
    local eline = vim.fn.getpos(".")[2]
    -- local ns_id = api.nvim_create_namespace("TranslateVirt")

    local mode = api.nvim_get_mode().mode

    if mode == 'V' then
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
                                { "  " .. res:gsub("^%s+", ''), "TranslateVirt" },
                            },
                        }

                        local ns_id = api.nvim_create_namespace("")

                        api.nvim_buf_set_extmark(0, ns_id, sline + i - 2, 0, virt_opts)
                    end
                end)
            )
        end
    elseif mode == 'v' then
        local str = table.concat(visual_tbl, '')

        str = str:gsub("%s%s+", ' ')

        -- TODO %s is actually \n
        local i = 1
        for line in string.gmatch(str, "[^%.]+") do
            local handle = nil
            local stdout = loop.new_pipe(false)
            handle = loop.spawn("curl", {
                    args = {
                        "-s", "-X", "POST", "https://api-free.deepl.com/v2/translate",
                        "-H", "Authorization: DeepL-Auth-Key 5b572043-9d05-0b9c-ace0-48acc8e38e0c:fx",
                        "-d", "target_lang=ZH&text=" .. line,
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
                                { "  " .. res, "TranslateVirt" },
                            },
                        }

                        local ns_id = api.nvim_create_namespace("")

                        api.nvim_buf_set_extmark(0, ns_id, sline + i - 2, 0, virt_opts)
                        i = i + 1
                    end
                end)
            )
        end
    end

end)

local str = [[
Expand wildcards and the following special keywords in
{string}. wildignorecase applies.

If {list} is given and it is |TRUE|, a List will be returned.
Otherwise the result is a String and when there are several
matches, they are separated by <NL> characters.

If the expansion fails, the result is an empty string. A name
for a non-existing file is not included, unless {string} does
not start with '%', '#' or '<', see below.

When {string} starts with '%', '#' or '<', the expansion is
done like for the |cmdline-special| variables with their
associated modifiers. Here is a short overview:

    %		current file name
    #		alternate file name
    #n		alternate file name n
    <cfile>		file name under the cursor
    <afile>		autocmd file name
    <abuf>		autocmd buffer number (as a String!)
    <amatch>	autocmd matched name
    <cexpr>		C expression under the cursor
    <sfile>		sourced script file or function name
    <slnum>		sourced script line number or function
            line number
    <sflnum>	script file line number, also when in
            a function
    <SID>		"<SNR>123_"  where "123" is the
            current script ID  |<SID>|
    <script>	sourced script file, or script file
            where the current function was defined
    <stack>		call stack
    <cword>		word under the cursor
    <cWORD>		WORD under the cursor
    <client>	the {clientid} of the last received
            message
Modifiers:
    :p		expand to full path
    :h		head (last path component removed)
    :t		tail (last path component only)
    :r		root (one extension removed)
    :e		extension only

Example:
    :let &tags = expand("%:p:h") .. "/tags"
Note that when expanding a string that starts with '%', '#' or
'<', any following text is ignored.  This does NOT work:
    :let doesntwork = expand("%:h.bak")
Use this:
    :let doeswork = expand("%:h") .. ".bak"
Also note that expanding "<cfile>" and others only returns the
referenced file name without further expansion.  If "<cfile>"
is "~/.cshrc", you need to do another expand() to have the
"~/" expanded into the path of the home directory:
    :echo expand(expand("<cfile>"))

There cannot be white space between the variables and the
following modifier.  The |fnamemodify()| function can be used
to modify normal file names.

When using '%' or '#', and the current or alternate file name
is not defined, an empty string is used.  Using "%:p" in a
buffer with no name, results in the current directory, with a
'/' added.
When 'verbose' is set then expanding '%', '#' and <> items
will result in an error message if the argument cannot be
expanded.

When {string} does not start with '%', '#' or '<', it is
expanded like a file name is expanded on the command line.
'suffixes' and 'wildignore' are used, unless the optional
{nosuf} argument is given and it is |TRUE|.
Names for non-existing files are included.  The "**" item can
be used to search in a directory tree.  For example, to find
all "README" files in the current directory and below:
    :echo expand("**/README")

expand() can also be used to expand variables and environment
variables that are only known in a shell.  But this can be
slow, because a shell may be used to do the expansion.  See
|expr-env-expand|.
The expanded variable is still handled like a list of file
names.  When an environment variable cannot be expanded, it is
left unchanged.  Thus ":echo expand('$FOOBAR')" results in
"$FOOBAR".

See |glob()| for finding existing files.  See |system()| for
getting the raw output of an external command.
]]

-- local api  = vim.api
-- local loop = vim.loop
-- 
-- local utils = require "utils"
-- 
-- vim.keymap.set('x', ',t', function ()
--     local visual_tbl = utils.get_visual_select()
--     local query_str  = table.concat(visual_tbl, '%0D')
-- 
-- 
--     query_str = query_str:gsub("%s", "%%20")
-- 
--     local handle = nil
--     local stdout = loop.new_pipe(false)
--     handle = loop.spawn("curl", {
--             args = {
--                 "-s", "-X", "POST", "https://api-free.deepl.com/v2/translate",
--                 "-H", "Authorization: DeepL-Auth-Key 5b572043-9d05-0b9c-ace0-48acc8e38e0c:fx",
--                 "-d", "target_lang=ZH&text=" .. query_str,
--             },
--             stdio = { nil, stdout, nil },
--         },
--         function()
--             stdout:read_stop()
--             stdout:close()
--             handle:close()
--         end
--     )
-- 
--     loop.read_start(stdout, vim.schedule_wrap (
--         function (err, data)
--             if data ~= nil then
--                 local res = vim.json.decode(data).translations[1].text
-- 
--                 local i = 0
--                 local sline = vim.fn.getpos('v')[2]
--                 for line in string.gmatch(res, "[^%s%s]+") do
-- 
--                     local ns_id = api.nvim_create_namespace("")
-- 
--                     local virt_opts = {
--                         id = 1,
--                         virt_text_pos = "eol",
--                         virt_text = {
--                             { "  " .. line, "TranslateVirt" },
--                         },
--                     }
-- 
--                     if api.nvim_buf_get_lines(0, sline + i - 1, sline + i, false)[1] == "" then
--                         i = i + 1
--                     end
-- 
--                     api.nvim_buf_set_extmark(0, ns_id, sline + i - 1, 0, virt_opts)
-- 
--                     i = i + 1
--                 end
-- 
--                 -- table.insert(res_tbl, res)
-- 
--                 -- local virt_opts = {
--                 --     id = 1,
--                 --     virt_text_pos = "eol",
--                 --     virt_text = {
--                 --         { "  " .. res:gsub("^%s+", ''), "TranslateVirt" },
--                 --     },
--                 -- }
--                 --
--                 -- local ns_id = api.nvim_create_namespace("")
--                 --
--                 -- api.nvim_buf_set_extmark(0, ns_id, sline + i - 2, 0, virt_opts)
--             end
--         end)
--     )
-- end)
