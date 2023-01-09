local api = vim.api

api.nvim_set_option_value("loadplugins", true, {})
api.nvim_set_option_value("runtimepath", "/home/nex/.local/share/nvim/lazy/lazy.nvim", {})

require "lazy".setup {
    spec = {
        { import = "plugins.lazy-plugins" }
    },
    root = "/home/nex/.local/share/nvim/lazy",
    defaults = {
        lazy = true,
    },
    lockfile = "/home/nex/.cache/nvim/lazy-lock.json",
    ui = {
        size = { width = 0.75, height = 0.75 },
        border = "rounded",
        icons = {
            cmd     = " ",
            config  = " ",
            event   = " ",
            ft      = " ",
            init    = " ",
            keys    = "ﱕ ",
            plugin  = " ",
            runtime = " ",
            source  = " ",
            start   = " ",
            task    = " ",
        },
        custom_keys = {
            [";l"] = function (plugin)
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
            -- disable_events = { "VimEnter", "BufReadPre" },
        },
        reset_packpath = true,
        rtp = {
            reset = false,
            -- paths = {
            -- "/home/nex/nvim",
            -- },
            paths = {
                -- "/home/nex/.local/share/nvim/lazy/lazy.nvim",
                "/home/nex/nvim",
                "/usr/share/nvim/runtime/"
            },
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                -- "filetype",
                "health",
                "man",
                "shada",
                "spellfile",
                "nvim",
                "rplugin",
                "zipPlugin",
            },
        },
    },
    readme = {
        root = "/home/nex/.local/state/lazy/readme",
        files = { "README.md" },
        skip_if_doc_exists = true,
    },
}

-- require "lazy".setup ("plugins.lazy-plugins", {
--         root = "/home/nex/.local/share/nvim/lazy",
--         defaults = {
--             lazy = true,
--         },
--         lockfile = "/home/nex/.cache/nvim/lazy-lock.json",
--         ui = {
--             size = { width = 0.75, height = 0.75 },
--             border = "rounded",
--             icons = {
--                 cmd     = " ",
--                 config  = " ",
--                 event   = " ",
--                 ft      = " ",
--                 init    = " ",
--                 keys    = "ﱕ ",
--                 plugin  = " ",
--                 runtime = " ",
--                 source  = " ",
--                 start   = " ",
--                 task    = " ",
--             },
--             custom_keys = {
--                 [";l"] = function (plugin)
--                     require("lazy.util").open_cmd({ "lazygit", "log" }, {
--                         cwd = plugin.dir,
--                         terminal = true,
--                         close_on_exit = true,
--                         enter = true,
--                     })
--                 end,
--
--                 [";x"] = function (plugin)
--                     require("lazy.util").open_cmd({ vim.go.shell }, {
--                         cwd = plugin.dir,
--                         terminal = true,
--                         close_on_exit = true,
--                         enter = true,
--                     })
--                 end,
--             },
--         },
--         checker = {
--             enabled = false,
--             notify = false,
--             frequency = 3600,
--         },
--         change_detection = {
--             enabled = false,
--             notify = false,
--         },
--         performance = {
--             cache = {
--                 enabled = true,
--                 path = "/hone/nex/.cache/nvim/lazy/cache",
--                 -- disable_events = { "VimEnter", "BufReadPre" },
--             },
--             reset_packpath = true,
--             rtp = {
--                 reset = false,
--                 -- paths = {
--                 -- "/home/nex/nvim",
--                 -- },
--                 paths = {
--                     -- "/home/nex/.local/share/nvim/lazy/lazy.nvim",
--                     "/home/nex/nvim",
--                     "/usr/share/nvim/runtime/"
--                 },
--                 disabled_plugins = {
--                     "gzip",
--                     "matchit",
--                     "matchparen",
--                     "netrwPlugin",
--                     "tarPlugin",
--                     "tohtml",
--                     "tutor",
--                     -- "filetype",
--                     "health",
--                     "man",
--                     "shada",
--                     "spellfile",
--                     "nvim",
--                     "rplugin",
--                     "zipPlugin",
--                 },
--             },
--         },
--         readme = {
--             root = "/home/nex/.local/state/lazy/readme",
--             files = { "README.md" },
--             skip_if_doc_exists = true,
--         },
--     }
-- )
