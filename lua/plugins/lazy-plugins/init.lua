
-- ~/nvim/nvim/lua/plugins/lazy-plugins/
return {
    { "norcalli/nvim-colorizer.lua",
       cmd = "ColorizerToggle",
       config = function ()
           require "colorizer".setup({ "*" }, { mode = "foreground" })
       end
    },
    { "nex-s/matchparen.nvim",
       event = "CursorHold",
       config = {},
    },
    { "lukas-reineke/indent-blankline.nvim",
       event = "CursorHold",
       config = {
           char = '╎',
           space_char_blankline = "･",
           show_trailing_blankline_indent = true,
           show_current_context           = false,
           show_current_context_start     = false,
           show_first_indent_level        = false,
           show_end_of_line               = false,
       },
    }
}
