
local api = vim.api
local cmd = vim.cmd

local multi_mode_tbl = {
    -- NORMAL MAP --
    normal_mode = {
        ["J"]  =  "8j",
        ["U"]  =  "<C-r>",
        [">"]  =  ">>",
        ["<"]  =  "<<",
        ["K"]  =  "8k",
        ["H"]  =  "^",
        ["L"]  =  "$",
        ["'"]  =  ";",

        ["+"]  =  "m0J`0",

        ["X"]  =  "<CMD>tabnew term://fish | startinsert<CR>",

        -- ["Y"]  =  "<CMD>silent!%y+<CR>",
        ["Y"]  =  "\"+y$",
        ["d"]  =  "\"dd",
        ["y"]  =  "\"+y",
        ["p"]  =  "\"+p",
        ["P"]  =  "\"+P",

        ["dd"]  =  "\"ddd",
        ["yy"]  =  "\"+yy",
        ["dp"]  =  "\"dp",
        ["dP"]  =  "\"dP",

        ["<A-k>"]  =  "<C-w>k",
        ["<A-j>"]  =  "<C-w>j",
        ["<A-h>"]  =  "<C-w>h",
        ["<A-l>"]  =  "<C-w>l",

        ["<A-LEFT>"]   =  "<C-w>H",
        ["<A-DOWN>"]   =  "<C-w>J",
        ["<A-UP>"]     =  "<C-w>K",
        ["<A-RIGHT>"]  =  "<C-w>L",

        ["<C-i>"]  =  "<C-a>",
        ["<C-d>"]  =  "<C-x>",

        ["<C-m>"] =  "q",
        -- todo CR check if register l is empty
        ["<CR>"]  =  "@l",

        ["<C-u>"]  =  "viw~",
        -- ["<C-r>"]  =  '"',

        ["<C-a>"]  =  "ggvG$",

        ["<UP>"]     =  "<C-o>",
        ["<DOWN>"]   =  "<C-i>",
        ["<LEFT>"]   =  "gT",
        ["<RIGHT>"]  =  "gt",

        ["<TAB>"]   = "<C-w><C-w>",
        ["<S-TAB>"] = "<C-w>p",

        -- LEADER MAP --
        [";f"] = "/",
        -- [";a"] = "ggvG$",

        [";q"] = "<CMD>quit!<CR>",
        -- [";w"] = "<CMD>write ++p<CR>", -- dont add !
        [";w"] = "<CMD>silent! write ++p | redrawstatus! <CR>", -- dont add !

        -- GX MAP --

        ["g)"] = "])",
        ["g("] = "[(",
        ["g}"] = "]}",
        ["g{"] = "[{",
    },

    -- VISUAL MAP --
    visual_mode = {
        ["J"] = "8j",
        ["K"] = "8k",
        ["H"] = "^",
        ["L"] = "$<LEFT>",

        [">"] = ">gv",
        ["<"] = "<gv",

        ["p"] = "\"+p",
        ["P"] = "\"+P",
        ["y"] = "\"+y",
        ["d"] = "\"dd",

        [";w"] = "<CMD>write ++p<CR>", -- dont add !
        [";q"] = "<CMD>quit!<CR>",

        ["<C-m>"] = "\"ly",

        ["aq"] = 'a"',
        ["iq"] = 'i"',

        ["<C-a>"]   =  "<NOP>",
        ["<C-x>"]   =  "<NOP>",
        ["<C-i>"]   =  "<C-a>gv",
        ["<C-d>"]   =  "<C-x>gv",
        ["g<C-i>"]  =  "g<C-a>gv",
        ["g<C-d>"]  =  "g<C-x>gv",

        -- ["<LEFT>"] = "=gv",
        -- ["<RIGHT>"] = "=gv",

        ["<A-k>"] = ":<C-u>silent!'<,'>move-2<CR>gv=gv",
        ["<A-j>"] = ":<C-u>silent!'<,'>move'>+<CR>gv=gv",

        -- ["<UP>"] = ":<C-u>silent! '<,'>move-2<CR>gv-gv",
        -- ["<DOWN>"] = ":<C-u>silent! '<,'>move'>+<CR>gv-gv",
    },

    -- OPTRATOR MAP --
    operat_mode = {
        ["J"] = "8j",
        ["K"] = "8k",
        ["H"] = "^",
        ["L"] = "$<LEFT>",

        ["aq"] = 'a"',
        ["iq"] = 'i"',

        -- ["lq"] = 'i"',
        -- ["l'"] = "i'",
        -- ['l"'] = 'i"',

        ["h("] = '<CMD>normal!F(vi(<CR>',
        ["h)"] = '<CMD>normal!F)vi)<CR>',
        ["l("] = '<CMD>normal!f(vi(<CR>',
        ["l)"] = '<CMD>normal!f)vi)<CR>',
        ["hb"] = '<CMD>normal!F)vi)<CR>',
        ["lb"] = '<CMD>normal!f(vi(<CR>',

        ["h["] = '<CMD>normal!F[vi[<CR>',
        ["h]"] = '<CMD>normal!F]vi]<CR>',
        ["l["] = '<CMD>normal!f[vi[<CR>',
        ["l]"] = '<CMD>normal!f]vi]<CR>',

        ["h<"] = '<CMD>normal!F<vi<<CR>',
        ["h>"] = '<CMD>normal!F>vi><CR>',
        ["l<"] = '<CMD>normal!f<vi<<CR>',
        ["l>"] = '<CMD>normal!f>vi><CR>',

        ["h{"] = '<CMD>normal!F{vi{<CR>',
        ["h}"] = '<CMD>normal!F}vi}<CR>',
        ["l{"] = '<CMD>normal!f{vi{<CR>',
        ["l}"] = '<CMD>normal!f}vi}<CR>',

        ["h'"] = "<CMD>normal!F'vi'<CR>",
        ["l'"] = "<CMD>normal!f'vi'<CR>", 

        ['h"'] = '<CMD>normal!F"vi"<CR>',
        ['l"'] = '<CMD>normal!f"vi"<CR>',


        ["h'"] = "<CMD>normal!F'vi'<CR>",
        ["l'"] = "<CMD>normal!f'vi'<CR>",

        -- TODO
        -- ["hq"] = '<CMD>normal!F"<CR>i"',
    },

    -- INSERT MAP --
    insert_mode = {
        ["<SPACE>"] = "<SPACE><C-g>u",
        ["<C-c>"]   = "<C-r>=",

        ["<UP>"]   =  "<C-v>",
        ["<C-v>"]  =  "<ESC>\"+pa",
    },

    -- COMMAND MAP --
    commnd_mode = {
        -- ["<LEFT>"] = "<LEFT>",
        -- ["<DOWN>"] = "<DOWN>",
        -- ["<UP>"] = "<UP>",
        -- ["<RIGHT>"] = "<RIGHT>",
    },

    -- TERMINAL MAP --
    termnl_mode = {
        ["<ESC>"]  =  "<C-\\><C-n>",
        -- ["<A-h>"]  =  "<CMD>wincmd h<CR>",
        -- ["<A-j>"]  =  "<CMD>wincmd j<CR>",
        -- ["<A-k>"]  =  "<CMD>wincmd k<CR>",
        -- ["<A-l>"]  =  "<CMD>wincmd l<CR>",

        ["<A-h>"]  =  "<C-\\><C-n><C-w><C-h>",
        ["<A-j>"]  =  "<C-\\><C-n><C-w><C-j>",
        ["<A-k>"]  =  "<C-\\><C-n><C-w><C-k>",
        ["<A-l>"]  =  "<C-\\><C-n><C-w><C-l>",
    },
}

local mode_map = {
    normal_mode = "n",
    visual_mode = "v",
    insert_mode = "i",
    operat_mode = "o",
    commnd_mode = "c",
    termnl_mode = "t",
}

for mode, mode_tbl in pairs(multi_mode_tbl) do
    for lhs, rhs in pairs(mode_tbl) do
        api.nvim_set_keymap(mode_map[mode], lhs, rhs, { noremap = true, silent = false })
    end
end

local function_map = {
    ["<C-=>"]  =  function ()

        local view = vim.fn.winsaveview()
        vim.cmd "normal!gg=G"
        vim.fn.winrestview(view)

        -- local c_pos = api.nvim_win_get_cursor(0)
        -- api.nvim_win_set_cursor(0, c_pos)
    end,

    [";r"] = vim.cmd.R,

    [";x"] = function ()
        local opts = {
            start_ins = true,
            resume    = true,
            term_name = "fish_shell",
            exit_key  = "<ESC>",
        }
        -- TODO rewrite terminal
        require "plugins.terminal".open_term_float("fish", opts, { title = " [ TERMINAL ] ", title_pos = "right", on_exit = function ()
            vim.cmd.quit()
            for line in io.lines("/tmp/nvim-vifm") do
                vim.cmd.tabnew(line)
            end
        end})
    end,

    [";t"] = require "plugins.translate".translate,
    [";q"] = function ()
        local M = {}

        -- local lastbuf = false
        -- for i = 1, vim.fn.bufnr("$") do
        --     if vim.fn.buflisted(i) then
        --         lastbuf = true
        --         break
        --     end
        -- end

        -- TODO
        -- if api.nvim_buf_get_name(0):match("term://.*vifm") then
        --     api.nvim_command("quit!")
        -- -- elseif vim.fn.tabpagenr("$") == 1 and lastbuf == true and api.nvim_buf_get_option(0, "modifiable") == true then
        -- if vim.fn.tabpagenr("$") == 1 and api.nvim_win_get_number(0) == 1 then
        if vim.fn.tabpagenr("$") == 1 and vim.fn.winnr("$") == 1 then

            api.nvim_set_option_value("laststatus", 0, {})

            api.nvim_command("enew")
            vim.fn.termopen("vifm --choose-files /tmp/nvim-vifm", { on_exit = function ()
                if M.action ~= nil then
                    api.nvim_set_option_value("laststatus", 3, {})
                    for line in io.lines("/tmp/nvim-vifm") do
                        -- if M.action == "tabnew " and api.nvim_buf_get_name(0):match("term://.*vifm") then
                        if api.nvim_buf_get_name(0):match("term://.*vifm") then
                            api.nvim_command("edit " .. line)
                        else
                            api.nvim_command(M.action .. line)
                        end
                    end

                    vim.loop.new_thread(function ()
                        os.remove("/tmp/nvim-vifm")
                    end)
                else
                    api.nvim_command("silent quitall!")
                end
            end})

            api.nvim_command("startinsert")

            local vifm_action = {
                ["<C-v>"] = function ()
                    M.action = "vsp"
                    return "l"
                end,
                ["<C-s>"] = function ()
                    M.action = "sp"
                    return "l"
                end,
                ["l"] = function ()
                    M.action = "tabnew "
                    return "l"
                end,
                ["<ESC>"] = function ()
                    return "<ESC>"
                end,
            }

            for lhs, rhs in pairs(vifm_action) do
                vim.keymap.set("t", lhs, rhs, { buffer = true, expr = true })
            end

            api.nvim_set_option_value("number", false, { buf = 0 })
            -- api.nvim_set_option_value("filetype", "", { buf = 0 })
        else
            pcall(api.nvim_command, "quit!")
        end
    end,
}


for lhs, rhs in pairs(function_map) do
    vim.keymap.set("n", lhs, rhs, { silent = true })
end

local file_action = {
    [";v"] = "vsp",
    [";s"] = "sp",
    ["gf"] = "tabnew",
    ["<C-s>"] = "vsp",
}

for lhs, rhs in pairs(file_action) do
    vim.keymap.set("n", lhs, function ()
        local cfile = vim.fn.expand("<cfile>")
        if cfile:match("/[-_a-zA-Z]") then
            api.nvim_command(rhs .. " " .. cfile)
        else
            api.nvim_command(rhs)
        end
    end)
end

