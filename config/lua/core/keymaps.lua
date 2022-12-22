
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
        ["q"]  =  "za",
        -- ["q"]  =  function ()
        --     vim.cmd "silent!normal!za"
        --     vim.cmd.redrawstatus()
        -- end,
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

        ["<A-LEFT>"]   =  "<C-w>H",
        ["<A-DOWN>"]   =  "<C-w>J",
        ["<A-UP>"]     =  "<C-w>K",
        ["<A-RIGHT>"]  =  "<C-w>L",

        ["<F1>"]  =  "<CMD>source %<CR>",

        ["<C-i>"]  =  "<C-a>",
        ["<C-d>"]  =  "<C-x>",

        ["<C-u>"]  =  "viw~",

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
        -- TODO
        api.nvim_set_keymap(mode_map[mode], lhs, rhs, { noremap = true, silent = false })
        -- vim.keymap.set(mode_map[mode], lhs, rhs, { silent = true })
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
    -- [";q"] = _G._bufline_close,
}


for lhs, rhs in pairs(function_map) do
    vim.keymap.set("n", lhs, rhs, { silent = true })
end

-- api.nvim_create_user_command("X", function() vim.cmd "normal!<C-w>H" end, {})
-- api.nvim_create_user_command("J", function() vim.cmd "normal!<C-w>J" end, {})
-- api.nvim_create_user_command("K", function() vim.cmd "normal!<C-w>K" end, {})
-- api.nvim_create_user_command("L", function() vim.cmd "normal!<C-w>L" end, {})

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

