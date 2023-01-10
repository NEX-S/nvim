require "UI.x-color".set_hl {
    ["@variable"]       = { bg = "NONE", fg = "#888888" },  -- var name
    ["@string"]         = { bg = "NONE", fg = "#585858" },  -- string
    ["@keyword"]        = { bg = "NONE", fg = "#777777" },  -- local return function
    ["@function"]       = { bg = "NONE", fg = "#9C8FDC" },  -- function
    ["@parameter"]      = { bg = "NONE", fg = "#9C8FDC" },  -- func args
    ["@number"]         = { bg = "NONE", fg = "#555555" },  -- number
    ["@constant"]       = { bg = "NONE", fg = "#C53B82" },  -- M.
    ["@boolean"]        = { bg = "NONE", fg = "#C53B82" },  -- true false
    ["@conditional"]    = { bg = "NONE", fg = "#9C8FDC" },  -- if then
    ["@repeat"]         = { bg = "NONE", fg = "#999999" },  -- for while
    ["@operator"]       = { bg = "NONE", fg = "#666666" },  -- =
    ["@punctuation"]    = { bg = "NONE", fg = "#444443" },  -- [] ,
    ["@constructor"]    = { bg = "NONE", fg = "#555555" },  -- { }
    ["@field"]          = { bg = "NONE", fg = "#666666" },  -- table key
    ["@method"]         = { bg = "NONE", fg = "#C53B82" },  -- :match :gsub

    ["@type"]           = { bg = "NONE", fg = "#555555" },  -- C: int float ..
    ["@property"]       = { bg = "NONE", fg = "#9D7CD8" },  -- C: ->xxx
    ["@include"]        = { bg = "NONE", fg = "#C3E88D" },  -- C: include
    ["@text.todo"]      = { bg = "NONE", fg = "#C3E88D" },  -- C: include

    ["@constant.builtin"]    = { bg = "NONE", fg = "#FF43BA" },  -- nil
    ["@function.builtin"]    = { bg = "NONE", fg = "#A7C080" },  -- print
    ["@type.definition"]     = { bg = "NONE", fg = "#9C8FDC" },  -- print
    ["@string.escape"]       = { bg = "NONE", fg = "#FF43BA" },  -- \n

    ["@keyword.return"]      = { bg = "NONE", fg = "#FF43BA" },  -- return
    ["@keyword.function"]    = { bg = "NONE", fg = "#FF43BA" },  -- function end
    ["@keyword.operator"]    = { bg = "NONE", fg = "#C53B82" },  -- and or not

    ["@comment"]        = { bg = "NONE", fg = "#484848", italic = true }, -- comment
}

local operator = {
    ["jf"] = "<CMD>TSTextobjectGotoNextStart      @function.inner | normal vif<CR>",
    ["kf"] = "<CMD>TSTextobjectGotoPreviousStart  @function.inner | normal vif<CR>",

    ["jc"] = "<CMD>TSTextobjectGotoNextStart      @class.inner | normal vic<CR>",
    ["kc"] = "<CMD>TSTextobjectGotoPreviousStart  @class.inner | normal vic<CR>",

    ["ji"] = "<CMD>TSTextobjectGotoNextStart      @conditional.inner | normal vii<CR>",
    ["ki"] = "<CMD>TSTextobjectGotoPreviousStart  @conditional.inner | normal vii<CR>",

    ["jl"] = "<CMD>TSTextobjectGotoNextStart      @loop.inner | normal vil<CR>",
    ["kl"] = "<CMD>TSTextobjectGotoPreviousStart  @loop.inner | normal vil<CR>",
}

local api = vim.api
for lhs, rhs in pairs(operator) do
    api.nvim_set_keymap("o", lhs, rhs, { noremap = true })
end

return {
    { "nvim-treesitter/nvim-treesitter",
       build = ":TSUpdate",
       -- event = "VimEnter",
       -- event = "BufReadPost",
       event = "VimEnter",
       opts = {
           auto_install = false,
           ensure_installed = { "lua", "c", "markdown", "vim" },
           sync_install = false,
           highlight = {
               enable = true,
               additional_vim_regex_highlighting = false,
               disable = function (lang, buf)
                   local max_filesize = 100 * 1024 -- 100 KB
                   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                   if ok and stats and stats.size > max_filesize then
                       return true
                   end
               end
           },
           indent = { enable = true },
           incremental_selection = { enable = false },
       },
       config = function (plugin, opts)
           require "nvim-treesitter.configs".setup(opts)
       end
       -- config = function ()
       --     require "nvim-treesitter.configs".setup {
       --         auto_install = false,
       --         ensure_installed = { "lua", "c", "markdown", "vim" },
       --         sync_install = false,
       --         highlight = {
       --             enable = true,
       --             additional_vim_regex_highlighting = false,
       --             disable = function (lang, buf)
       --                 local max_filesize = 100 * 1024 -- 100 KB
       --                 local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
       --                 if ok and stats and stats.size > max_filesize then
       --                     return true
       --                 end
       --             end
       --         },
       --         indent = { enable = true },
       --         incremental_selection = { enable = false },
       --     }
       -- end,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        -- keys = { "c", "v", "d" },
        opts = {
            textobjects = {
                -- MOVE
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["<C-.>"] = "@function.outer"
                    },
                    goto_next_end = {
                        ["<C-]>"] = "@function.outer"
                    },
                    goto_previous_start = {
                        -- ["<F1>"] = "@function.outer"
                        ["<C-,>"] = "@function.outer"
                    },
                    goto_previous_end = {
                        ["<F1>"] = "@function.outer"
                    },
                },
                select = {
                    enable = true,
                    lookhead = false,
                    keymaps = {
                        ["if"] = "@function.inner",
                        ["af"] = "@function.outer",

                        ["ic"] = "@class.inner",
                        ["ac"] = "@class.outer",

                        -- ["c"] = "@call.inner",  -- all call args
                        -- ["C"] = "@call.outer",

                        ["ii"] = "@conditional.inner",
                        ["ai"] = "@conditional.outer",

                        ["il"] = "@loop.inner",
                        ["al"] = "@loop.outer",

                        ["ia"] = "@parameter.inner",
                        ["aa"] = "@parameter.outer",
                    },
                }
            },
        },
        config = function (plugin, opts)
            require "nvim-treesitter.configs".setup(opts)
        end
    },
}

-- dependencies = {
-- { "nvim-treesitter/nvim-treesitter-context",
--     ft = "markdown",
--     config = {
--         enable = true,
--         mode = "cursor",
--         patterns = {
--             -- default = {
--             --     "class",
--             --     "function",
--             --     "method",
--             --     "for",
--             --     "while",
--             --     "if",
--             --     "switch",
--             --     "case",
--             --     "interface",
--             --     "struct",
--             --     "enum",
--             -- },
--             markdown = {
--                 "section",
--             }
--         }
--     }
-- },
-- },
