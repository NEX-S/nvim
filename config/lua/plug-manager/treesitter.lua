
vim.cmd [[
    packadd nvim-treesitter.git
    packadd nvim-treesitter-context.git
    packadd nvim-treesitter-textobjects.git
]]

require "nvim-treesitter.configs".setup {
    auto_install = true,
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
    -- MOVE
    -- move = {
    --     enable = true,
    --     set_jumps = true,
    --     goto_next_start = {
    --         [";j"] = "@function.outer"
    --     },
    --     goto_next_end = {
    --         -- ["]"] = "@function.outer"
    --     },
    --     goto_previous_start = {
    --         [";k"] = "@function.outer"
    --     },
    --     goto_previous_end = {
    --         -- ["]"] = "@function.outer"
    --     },
    -- },
}

require "treesitter-context".setup {
    enable = true,
    mode = "topline",
    patterns = {
        default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
            "interface",
            "struct",
            "enum",
        },
        markdown = {
            "section",
        }
    }
}