
vim.api.nvim_command [[
    packadd nvim-treesitter
]]

require "nvim-treesitter.configs".setup {
    auto_install = false,
    ensure_installed = { "lua", "c", "markdown", "vim" },
    sync_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function (lang, buf)
            local max_filesize = 10 * 1024 -- 10 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end
    },
    indent = { enable = true },
    incremental_selection = { enable = false },

    -- TEXT OBJECTS
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

                ["ii"] = "@conditional.inner",  -- if
                ["ai"] = "@conditional.outer",  -- if

                ["il"] = "@loop.inner", -- loop
                ["al"] = "@loop.outer", -- loop

                ["ia"] = "@parameter.inner",  -- args
                ["aa"] = "@parameter.outer",  -- args

                -- ["is"] = "@statement.outer", -- statement
            },
        }
    },
}

-- require "treesitter-context".setup {
--     enable = true,
--     mode = "topline",
--     patterns = {
--         default = {
--             "class",
--             "function",
--             "method",
--             "for",
--             "while",
--             "if",
--             "switch",
--             "case",
--             "interface",
--             "struct",
--             "enum",
--         },
--         markdown = {
--             "section",
--         }
--     }
-- }

require "UI.x-color".set_hl {
    ["@variable"]       = { bg = "#232323", fg = "#888888" }, -- var name
    ["@string"]         = { bg = "#232323", fg = "#585858" }, -- string
    ["@comment"]        = { bg = "#232323", fg = "#484848", italic = true }, -- comment
    ["@keyword"]        = { bg = "#232323", fg = "#777777" }, -- local return function
    ["@function"]       = { bg = "#232323", fg = "#9C8FDC", bold = false }, -- function
    ["@parameter"]      = { bg = "#232323", fg = "#9C8FDC" }, -- func args
    ["@number"]         = { bg = "#232323", fg = "#555555" }, -- number
    ["@constant"]       = { bg = "#232323", fg = "#C53B82" }, -- M.
    ["@boolean"]        = { bg = "#232323", fg = "#C53B82" }, -- true false
    ["@conditional"]    = { bg = "#232323", fg = "#9C8FDC" }, -- if then
    ["@repeat"]         = { bg = "#232323", fg = "#999999" }, -- for while
    ["@operator"]       = { bg = "#232323", fg = "#666666" }, -- =
    ["@punctuation"]    = { bg = "#232323", fg = "#444443" }, -- [] ,
    ["@constructor"]    = { bg = "#232323", fg = "#555555" }, -- { }
    ["@field"]          = { bg = "#232323", fg = "#666666" }, -- table key
    ["@method"]         = { bg = "#232323", fg = "#C53B82" }, -- :match :gsub

    ["@type"]           = { bg = "#232323", fg = "#555555" }, -- C: int float ..
    ["@property"]       = { bg = "#232323", fg = "#9D7CD8" }, -- C: ->xxx
    ["@include"]        = { bg = "#232323", fg = "#C3E88D" }, -- C: include
    ["@text.todo"]        = { bg = "#232323", fg = "#C3E88D" }, -- C: include

    ["@constant.builtin"]    = { bg = "#232323", fg = "#FF43BA" }, -- nil
    ["@function.builtin"]    = { bg = "#232323", fg = "#A7C080" }, -- print
    ["@type.definition"]     = { bg = "#232323", fg = "#9C8FDC" }, -- print
    ["@string.escape"]       = { bg = "#232323", fg = "#FF43BA" }, -- \n

    ["@keyword.return"]      = { bg = "#232323", fg = "#FF43BA" }, -- return
    ["@keyword.function"]    = { bg = "#232323", fg = "#FF43BA" }, -- function end
    ["@keyword.operator"]    = { bg = "#232323", fg = "#C53B82" }, -- and or not
}
