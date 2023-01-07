
local api = vim.api
local cmd = vim.cmd

local multi_mode_tbl = {
    -- NORMAL MAP --
    normal_mode = {
        ["j"]  =  "gj",
        ["k"]  =  "gk",

        ["J"]  =  "8gj",
        ["K"]  =  "8gk",
        ["H"]  =  "g^",
        ["L"]  =  "g$",

        ["gH"]  =  "^",
        ["gL"]  =  "$",

        ["U"]  =  "<C-r>",
        [">"]  =  ">>",
        ["<"]  =  "<<",
        ["'"]  =  ",",
        ["R"]  =  "gR",

        ["q"]  =  "za",

        ["+"]  =  "m0J`0",

        ["X"]  =  "<CMD>tabnew term://fish | startinsert<CR>",

        -- ["Y"]  =  "<CMD>silent!%y+<CR>",
        ["Y"]  =  "\"+y$",
        ["d"]  =  "\"dd",
        ["y"]  =  "\"+y",
        ["p"]  =  "\"+p",
        ["P"]  =  "\"+gP",

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

        ["="]  =  "<C-a>",
        ["-"]  =  "<C-x>",

        ["<C-m>"] =  "q",
        -- todo CR check if register l is empty
        ["<CR>"]  =  "@l",

        ["<C-u>"]  =  "viw~",
        -- ["<C-r>"]  =  '"',


        ["<C-a>"]  =  "ggvG$",
        -- ["<C-c>"]  =  "q:<CMD>nnoremap <buffer> <ESC> :quit<cr> <CR>",

        ["<UP>"]     =  "<C-o>",
        ["<DOWN>"]   =  "<C-i>",
        ["<LEFT>"]   =  "gT",
        ["<RIGHT>"]  =  "gt",

        ["<TAB>"]   = "<C-w><C-w>",
        ["<S-TAB>"] = "<C-w>p",

        ["<C-f>"] = "/",
        ["<C-r>"] = "@",
        -- [";a"] = "ggvG$",

        ["<C-q>"] = "<CMD>quit!<CR>",
        ["<C-w>"] = "<CMD>silent! write ++p | redrawstatus! <CR>", -- dont add !

        -- ["<C-c>"] = "q:",

        -- GX MAP --

        [")"] = "])",
        ["("] = "[(",
        ["}"] = "]}",
        ["{"] = "[{",
        -- ["]"] = "]]",
        -- ["["] = "[[",

        -- [";g"] = "<CMD>silent! execute 'grep! -R'  . shellescape('<cword>'). ' . ' | copen<CR>"
    },

    -- VISUAL MAP --
    visual_mode = {
        ["j"]  =  "gj",
        ["k"]  =  "gk",

        ["s"]  =  "\"ss",

        ["J"]  =  "8gj",
        ["K"]  =  "8gk",
        ["H"]  =  "g^",
        ["L"]  =  "$h",

        [">"] = ">gv",
        ["<"] = "<gv",

        ["p"] = "\"+p",
        ["P"] = "\"+P",
        ["y"] = "\"+y",
        ["d"] = "\"dd",

        ["<C-w>"] = "<CMD>write ++p<CR>", -- dont add !
        ["<C-q>"] = "<CMD>quit!<CR>",
        ["."] = ":normal! .<CR>",

        ["<C-r>"] = "@",

        ["<C-c>"] = "\"+y",

        ["<C-m>"] = "\"ly",

        ["<C-u>"] = "Ue",

        ["aq"] = 'a"',
        ["iq"] = 'i"',

        ["="]   =  "<C-a>gv",
        ["-"]   =  "<C-x>gv",
        ["<C-=>"]  =  "g<C-a>gv",
        ["<C-->"]  =  "g<C-x>gv",

        ["<C-q>"] = "<CMD>quit!<CR>",
        ["<C-w>"] = "<CMD>silent! write ++p | redrawstatus! <CR>", -- dont add !

        -- ["<LEFT>"] = "=gv",
        -- ["<RIGHT>"] = "=gv",

        -- ["<A-k>"] = ":<C-u>silent!'<,'>move-2<CR>gv=gv",
        -- ["<A-j>"] = ":<C-u>silent!'<,'>move'>+<CR>gv=gv",

        -- ["<UP>"] = ":<C-u>silent! '<,'>move-2<CR>gv-gv",
        -- ["<DOWN>"] = ":<C-u>silent! '<,'>move'>+<CR>gv-gv",
    },

    -- OPTRATOR MAP --
    operat_mode = {
        -- ["J"] = "8j",
        -- ["K"] = "8k",
        ["H"] = "^",
        ["L"] = "$<LEFT>",

        ["aq"] = 'a"',
        ["iq"] = 'i"',

        -- ["lq"] = 'i"',
        -- ["l'"] = "i'",
        -- ['l"'] = 'i"',

        ["h("] = '<CMD>normal! F(vi(<CR>',
        ["h)"] = '<CMD>normal! F)vi)<CR>',
        ["l("] = '<CMD>normal! f(vi(<CR>',
        ["l)"] = '<CMD>normal! f)vi)<CR>',
        ["hb"] = '<CMD>normal! F)vi)<CR>',
        ["lb"] = '<CMD>normal! f(vi(<CR>',

        ["h["] = '<CMD>normal! F[vi[<CR>',
        ["h]"] = '<CMD>normal! F]vi]<CR>',
        ["l["] = '<CMD>normal! f[vi[<CR>',
        ["l]"] = '<CMD>normal! f]vi]<CR>',

        ["h<"] = '<CMD>normal! F<vi<<CR>',
        ["h>"] = '<CMD>normal! F>vi><CR>',
        ["l<"] = '<CMD>normal! f<vi<<CR>',
        ["l>"] = '<CMD>normal! f>vi><CR>',

        ["h{"] = '<CMD>normal! F{vi{<CR>',
        ["h}"] = '<CMD>normal! F}vi}<CR>',
        ["l{"] = '<CMD>normal! f{vi{<CR>',
        ["l}"] = '<CMD>normal! f}vi}<CR>',

        ["h'"] = "<CMD>normal! F'vi'<CR>",
        ["l'"] = "<CMD>normal! f'vi'<CR>",

        ['h"'] = '<CMD>normal! F"vi"<CR>',
        ['l"'] = '<CMD>normal! f"vi"<CR>',
        ['hq'] = '<CMD>normal! F"vi"<CR>',
        ['lq'] = '<CMD>normal! f"vi"<CR>',


        ["h'"] = "<CMD>normal! F'vi'<CR>",
        ["l'"] = "<CMD>normal! f'vi'<CR>",

        -- TODO
        -- ["hq"] = '<CMD>normal!F"<CR>i"',
    },

    -- INSERT MAP --
    insert_mode = {
        ["<SPACE>"] = "<SPACE><C-g>u",
        ["<C-c>"]   = "<C-r>=",

        ["<UP>"]   =  "<C-v>",
        ["<C-v>"]  =  "<ESC>\"+pa",

        ["<C-q>"] = "<ESC>",
        ["<C-w>"] = "<CMD>silent! write ++p | redrawstatus! <CR>", -- dont add !
    },

    -- COMMAND MAP --
    commnd_mode = {
        -- ["<LEFT>"] = "<LEFT>",
        -- ["<DOWN>"] = "<DOWN>",
        -- ["<UP>"] = "<UP>",
        -- ["<RIGHT>"] = "<RIGHT>",
        ["<C-v>"] = "<C-r>+",
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
    ["<C-i>"]  =  function ()

        local view = vim.fn.winsaveview()
        vim.cmd "normal!gg=G"
        vim.fn.winrestview(view)

        -- local c_pos = api.nvim_win_get_cursor(0)
        -- api.nvim_win_set_cursor(0, c_pos)
    end,

    [",r"] = vim.cmd.R,

    [",x"] = function ()
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

    ["<C-c>"]  = function ()
        -- api.nvim_command("normal! q:")
        api.nvim_input("<C-m>:")
        vim.defer_fn(function ()
            api.nvim_buf_set_keymap(0, "n", "<ESC>", "<CMD>quit!<CR>", { noremap = true })
        end, 100)
    end,
    ["<C-q>"] = function ()
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
    [",v"] = "vsp",
    [",s"] = "sp",
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

local function_omap = {
    ["j{"] = function ()
        local reg = vim.fn.getreg("/")
        vim.fn.setreg("/", "{")
        api.nvim_command("normal! nvi{")
        vim.fn.setreg("/", reg)
    end,
    ["k{"] = function ()
        local reg = vim.fn.getreg("/")
        vim.fn.setreg("/", "}")
        api.nvim_command("normal! Nvi}")
        vim.fn.setreg("/", reg)
    end,
}

for lhs, rhs in pairs(function_omap) do
    vim.keymap.set("o", lhs, rhs, { expr = false })
end
