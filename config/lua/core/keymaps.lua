
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

        ["<C-j>"]   =  "<C-i>",
        ["<C-k>"]   =  "<C-o>",
        ["<C-h>"]   =  "<CMD>tabprevious<CR>",
        ["<C-l>"]   =  "<CMD>tabnext<CR>",

        ["<TAB>"]    = "<C-w>p",
        ["<S-TAB>"]  = "<C-w><C-w>",

        ["<F10>"]  =  "<CMD>bp<CR>",
        ["<F11>"]  =  "<CMD>bn<CR>",

        -- LEADER MAP --
        [";f"] = "/",
        [";a"] = "ggvG$",

        [";q"] = "<CMD>quit!<CR>",
        [";w"] = "<CMD>write! ++p<CR>",
        [";r"] = "<CMD>R<CR>",
        [";s"] = "<CMD>split<CR>",
        [";v"] = "<CMD>vertical split<CR>",

        [";x"] = function ()
            local opts = {
                start_ins = true,
                resume    = true,
                term_name = ";x",
                exit_key  = "<ESC>",
            }
            require "plugins.terminal".open_term_float("fish", opts, { title = " [ TERMINAL ] ", title_pos = "right" })
        end,

        [";t"] = require "plugins.translate".translate,

        -- GX MAP --
        ["gf"] = function ()
            local file_dir = vim.fn.expand("<cfile>")
            if file_dir:match("/") then
                vim.cmd("tabnew " .. file_dir)
            end
        end,
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

        [";w"] = "<CMD>write!<CR>",
        [";q"] = "<CMD>quit!<CR>",

        [";t"] = require "plugins.translate".translate,
    },

    -- OPTRATOR MAP --
    operat_mode = {
        ["j"] = "gj",
        ["k"] = "gk",

        ["J"] = "8j",
        ["K"] = "8k",
        ["H"] = "^",
        ["L"] = "$<LEFT>",
    },

    -- INSERT MAP --
    insert_mode = {
        ["<SPACE>"] = "<SPACE><C-g>u",
    },

    -- COMMAND MAP --
    commnd_mode = {
        ["<C-h>"] = "<LEFT>",
        ["<C-j>"] = "<DOWN>",
        ["<C-k>"] = "<UP>",
        ["<C-l>"] = "<RIGHT>",
    },

    -- TERMINAL MAP --
    termnl_mode = {
        ["<ESC>"]  =  "<C-\\><C-n>",
        ["<C-h>"]  =  "<LEFT>",
        ["<C-j>"]  =  "<DOWN>",
        ["<C-k>"]  =  "<UP>",
        ["<C-l>"]  =  "<RIGHT>",
    },
}

_G.async_set_keymap = vim.loop.new_async (
    vim.schedule_wrap(
        function ()
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

            _G.async_set_keymap:close()
        end
    )
)

async_set_keymap:send()
