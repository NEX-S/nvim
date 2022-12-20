
local api = vim.api
local cmd = vim.cmd

local multi_mode_tbl = {
    -- NORMAL MAP --
    normal_mode = {
        -- ["j"]  =  "gj",
        -- ["k"]  =  "gk",

        ["J"]  =  "8j",
        ["U"]  =  "<C-r>",
        [">"]  =  ">>",
        ["<"]  =  "<<",
        ["q"]  =  "<NOP>",
        ["K"]  =  "8k",
        ["H"]  =  "^",
        ["L"]  =  "$",
        ["+"]  =  "m0J`0",

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

        ["<F1>"]  =  "<CMD>source %<CR>",

        ["<C-=>"]  =  function ()

            local view = vim.fn.winsaveview()
            vim.cmd "normal!gg=G"
            vim.fn.winrestview(view)

            -- local c_pos = api.nvim_win_get_cursor(0)
            -- api.nvim_win_set_cursor(0, c_pos)
        end,

        ["<C-i>"]  =  "<C-a>",
        ["<C-d>"]  =  "<C-x>",

        ["<C-u>"]  =  "viw~",

        ["<C-a>"]  =  "ggvG$",

        ["<UP>"]     =  "<C-o>",
        ["<DOWN>"]   =  "<C-i>",
        -- ["<LEFT>"]   =  "<CMD>tabprevious<CR>",
        -- ["<RIGHT>"]  =  "<CMD>tabnext<CR>",
        -- ["<LEFT>"]   =  "gT",
        -- ["<RIGHT>"]  =  "gt",
        ["<LEFT>"]   =  vim.cmd.tabprevious,
        ["<RIGHT>"]  =  vim.cmd.tabnext,

        -- ["<C-,>"]  =  "<CMD>tabprevious<CR>",
        -- ["<C-.>"]  =  "<CMD>tabnext<CR>",

        ["<TAB>"]   = "<C-w><C-w>",
        ["<S-TAB>"] = "<C-w>p",

        -- LEADER MAP --
        [";f"] = "/",
        -- [";a"] = "ggvG$",

        [";q"] = "<CMD>quit!<CR>",
        -- [";w"] = "<CMD>write ++p<CR>", -- dont add !
        [";w"] = "<CMD>silent! write ++p | redrawstatus! <CR>", -- dont add !
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

        -- GX MAP --

        ["g)"] = "])",
        ["g("] = "[(",
        ["g}"] = "]}",
        ["g{"] = "[{",

    },

    -- VISUAL MAP --
    visual_mode = {
        -- ["j"] = "gj",
        -- ["k"] = "gk",

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

        [";t"] = require "plugins.translate".translate,

        ["aq"] = 'a"',
        ["iq"] = 'i"',

        ["<C-i>"]  =  "g<C-a>gv",
        ["<C-d>"]  =  "g<C-x>gv",

        -- ["<LEFT>"] = "=gv",
        -- ["<RIGHT>"] = "=gv",

        ["<A-k>"] = ":<C-u>silent!'<,'>move-2<CR>gv=gv",
        ["<A-j>"] = ":<C-u>silent!'<,'>move'>+<CR>gv=gv",

        -- ["<UP>"] = ":<C-u>silent! '<,'>move-2<CR>gv-gv",
        -- ["<DOWN>"] = ":<C-u>silent! '<,'>move'>+<CR>gv-gv",
    },

    -- OPTRATOR MAP --
    operat_mode = {
        -- ["j"] = "gj",
        -- ["k"] = "gk",

        ["J"] = "8j",
        ["K"] = "8k",
        ["H"] = "^",
        ["L"] = "$<LEFT>",

        ["aq"] = 'a"',
        ["iq"] = 'i"',
        ["lq"] = 'i"',

        ["l'"] = "i'",
        ['l"'] = 'i"',

        -- TODO
        -- ["hq"] = '<CMD>normal!F"<CR>i"',
    },

    -- INSERT MAP --
    insert_mode = {
        ["<SPACE>"] = "<SPACE><C-g>u",
        ["<C-c>"]   = "<C-r>=",
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
        ["<LEFT>"]  =  "<LEFT>",
        ["<DOWN>"]  =  "<DOWN>",
        ["<UP>"]  =  "<UP>",
        ["<RIGHT>"]  =  "<RIGHT>",
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
        vim.keymap.set(mode_map[mode], lhs, rhs, { silent = true })
    end
end
