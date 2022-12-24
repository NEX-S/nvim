
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
