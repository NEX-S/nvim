
local multi_mode_tbl = {
    -- NORMAL MAP --
    normal_mode = {


        ["j"]  =  "gj",
        ["k"]  =  "gk",

        ["J"]  =  "8j",
        ["U"]  =  "<C-r>",
        [">"]  =  ">>",
        ["<"]  =  "<<",
        ["q"]  =  "<NOP>",
        ["K"]  =  "8k",
        ["H"]  =  "^",
        ["L"]  =  "$",
        ["+"]  =  "J",
        ["Y"]  =  "<CMD>silent!%y+<CR>",

        ["d"]  =  '"dd',
        ["y"]  =  '"+y',
        ["p"]  =  '"+p',
        ["P"]  =  '"+P',

        ["dd"]  =  '"ddd',
        ["yy"]  =  '"+yy',
        ["dp"]  =  '"dp',
        ["dP"]  =  '"dP',

        ["<A-k>"]  =  "<C-w>k",
        ["<A-j>"]  =  "<C-w>j",
        ["<A-h>"]  =  "<C-w>h",
        ["<A-l>"]  =  "<C-w>l",

        ["<C-s>"]  =  "<CMD>source %<CR>",


        -- ["<C-i>"]  =  "<C-a>",
        -- ["<C-d>"]  =  "<C-x>",
        -- ["<C-i>"]  =  "g<C-a>",
        -- ["<C-d>"]  =  "g<C-x>",
        ["<C-u>"]  =  "viw~",

        ["<DOWN>"]   =  "<C-i>",
        ["<UP>"]   =  "<C-o>",
        ["<LEFT>"]   =  "<CMD>tabprevious<CR>",
        ["<RIGHT>"]   =  "<CMD>tabnext<CR>",

        ["<TAB>"]   = "<C-w><C-w>",
        ["<S-TAB>"] = "<C-w>p",

        ["<F10>"]  =  "<CMD>bp<CR>",
        ["<F11>"]  =  "<CMD>bn<CR>",

        -- LEADER MAP --
        [";f"] = "/",
        [";a"] = "ggvG$",

        [";q"] = "<CMD>quit!<CR>",
        [";w"] = "<CMD>write ++p<CR>", -- dont add !
        [";r"] = "<CMD>R<CR>",

        [";x"] = function ()
            local opts = {
                start_ins = true,
                resume    = true,
                term_name = "fish_shell",
                exit_key  = "<ESC>",
            }
            -- TODO rewrite terminal
            require "plugins.terminal".open_term_float("fish", opts, { title = " [ TERMINAL ] ", title_pos = "right", on_exit = function ()
                vim.cmd "quit"
                for line in io.lines("/tmp/nvim-vifm") do
                    vim.cmd("tabnew " .. line)
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
        ["j"] = "gj",
        ["k"] = "gk",

        ["J"] = "8j",
        ["K"] = "8k",
        ["H"] = "^",
        ["L"] = "$<LEFT>",

        [">"] = ">gv",
        ["<"] = "<gv",

        ["p"] = '"+p',
        ["P"] = '"+P',
        ["y"] = '"+y',
        ["d"] = '"dd',

        [";w"] = "<CMD>write<CR>",
        [";q"] = "<CMD>quit!<CR>",

        [";t"] = require "plugins.translate".translate,

        ["aq"] = 'a"',
        ["iq"] = 'i"',

        ["<LEFT>"] = "=gv",
        ["<RIGHT>"] = "=gv",
        -- AUTOINDENT
        ["<UP>"] = ":<C-u>silent! '<,'>move-2<CR>gv=gv",
        ["<DOWN>"] = ":<C-u>silent! '<,'>move'>+<CR>gv=gv",
        -- NOINDENT
        -- ["<UP>"] = ":<C-u>silent! '<,'>move-2<CR>gv-gv",
        -- ["<DOWN>"] = ":<C-u>silent! '<,'>move'>+<CR>gv-gv",
    },

    -- OPTRATOR MAP --
    operat_mode = {
        ["j"] = "gj",
        ["k"] = "gk",

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
        ["<LEFT>"] = "<LEFT>",
        ["<DOWN>"] = "<DOWN>",
        ["<UP>"] = "<UP>",
        ["<RIGHT>"] = "<RIGHT>",
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
        vim.keymap.set(mode_map[mode], lhs, rhs, { silent = false })
    end
end
