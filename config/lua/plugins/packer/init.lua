
vim.defer_fn(function ()
    local packer = require "packer"

    packer.init {
        auto_clean = true,
        compile_on_sync = true,
        git = { clone_timeout = 6000 },
        prompt_border = "single",
        -- compile_path = "/home/nex/.cache/nvim/packer_compiled.lua",
        keybindings = {
            quit = "<ESC>",
            toggle_info = "l",
        },
        display = {
            working_sym = " ",
            error_sym = " ",
            done_sym = " ",
            removed_sym = " -",
            moved_sym = "",
            open_fn = function ()
                return require "packer.util".float { border = "single" }
            end,
        }
    }

    packer.startup {
        function (use)
            use { "wbthomason/packer.nvim" }
            use { "lewis6991/impatient.nvim" }

            -- NVIM-COLORIZER
            use { "norcalli/nvim-colorizer.lua",
                config = [[ require "colorizer".setup({ "*" }, { mode = "foreground" }) ]]
            }

            -- TREESITTER
            -- ~/.config/nvim/lua/plugins/packer/treesitter.lua
            use { "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate",
                config = [[ require "plugins.packer.treesitter" ]],
            }
            use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }
            use { "nvim-treesitter/nvim-treesitter-context", module = "treesitter-context" }
        end
    }
end, 1000)

