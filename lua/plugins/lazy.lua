require "lazy".setup (
    -- PLUGINS
    {
        "nvim-treesitter/nvim-treesitter",
         build = ":TSUpdate",
         dependencies = {
             "nvim-treesitter/nvim-treesitter-textobjects",
         },
    }, 
    -- LAZY CONFIG
    {
        root = "/home/nex/.local/share/nvim/lazy",
        defaults = {
            lazy = true,
        },
        lockfile = "/home/nex/.cache/nvim/lazy-lock.json",
        ui = {
            size = { width = 0.75, height = 0.75 },
            border = "rounded",
            icons = {
                cmd     = " ",
                config  = " ",
                event   = " ",
                ft      = " ",
                init    = " ",
                keys    = " ",
                plugin  = " ",
                runtime = " ",
                source  = " ",
                start   = " ",
                task    = "✔ ",
            },
            custom_keys = {
                ["<C-l>"] = function (plugin)
                    require("lazy.util").open_cmd({ "lazygit", "log" }, {
                        cwd = plugin.dir,
                        terminal = true,
                        close_on_exit = true,
                        enter = true,
                    })
                end,

                [";x"] = function (plugin)
                    require("lazy.util").open_cmd({ vim.go.shell }, {
                        cwd = plugin.dir,
                        terminal = true,
                        close_on_exit = true,
                        enter = true,
                    })
                end,
            },
        },
        checker = {
            enabled = false,
            notify = false,
            frequency = 3600,
        },
        change_detection = {
            enabled = false,
            notify = false,
        },
        performance = {
            cache = {
                enabled = true,
                path = "/hone/nex/.cache/nvim/lazy/cache",
                disable_events = { "VimEnter", "BufReadPre" },
            },
            reset_packpath = true,
            rtp = {
                reset = false,
                -- paths = {
                -- "/home/nex/nvim",
                -- },
                disabled_plugins = {
                    -- "gzip",
                    -- "matchit",
                    -- "matchparen",
                    -- "netrwPlugin",
                    -- "tarPlugin",
                    -- "tohtml",
                    -- "tutor",
                    -- "zipPlugin",
                },
            },
        },
        readme = {
            root = vim.fn.stdpath("state") .. "/lazy/readme",
            files = { "README.md" },
            skip_if_doc_exists = true,
        },
    }
)


vim.defer_fn(function ()
    require "plugins.lazy-plugins.treesitter"
end, 10)
