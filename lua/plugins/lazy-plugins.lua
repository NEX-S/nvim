
-- ~/nvim/nvim/lua/plugins/lazy-plugins/
return {
    { "norcalli/nvim-colorizer.lua",
       init = function ()
           vim.defer_fn(function ()
               require "colorizer".setup({ "*" }, { mode = "foreground" })
           end, 50)
       end
    },
    { "nex-s/matchparen.nvim",
       init = function ()
           vim.defer_fn(function ()
               require "matchparen".setup {}
           end, 200)
       end
    },
    -- { "mbbill/undotree",
    --    cmd = "UndotreeToggle",
    -- },
}
