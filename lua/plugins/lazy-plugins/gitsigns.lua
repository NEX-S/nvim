
require "UI.x-color".set_hl {
    GitSignsAdd       = { bg = "NONE", fg = "#AFC460" },
    GitSignsChange    = { bg = "NONE", fg = "#FE8019" },
    GitSignsDelete    = { bg = "NONE", fg = "#E02C6D" },
    GitSignsUntrack   = { bg = "NONE", fg = "#333333" },

    -- GitSignsTablineAdd       = { bg = "#191919", fg = "#333333", italic = true },
    -- GitSignsTablineChange    = { bg = "#191919", fg = "#444444", italic = true },
    -- GitSignsTablineDelete    = { bg = "#191919", fg = "#E02C6D", italic = true },

    GitSignsStatusLineAdd       = { bg = "NONE", fg = "#AFC460" },
    GitSignsStatusLineChange    = { bg = "NONE", fg = "#FE8019" },
    GitSignsStatusLineDelete    = { bg = "NONE", fg = "#E02C6D" },

    GitSignsAddLn     = { bg = "NONE", fg = "#AFC460" },
    GitSignsChangeLn  = { bg = "NONE", fg = "#FE8019" },
    GitSignsDeleteLn  = { bg = "NONE", fg = "#E02C6D" },
    GitSignsUntrackLn = { bg = "NONE", fg = "#E02C6D" },

    GitSignsAddNr     = { bg = "NONE", fg = "#AFC460" },
    GitSignsChangeNr  = { bg = "NONE", fg = "#FE8019" },
    GitSignsDeleteNr  = { bg = "NONE", fg = "#E02C6D" },
    GitSignsUntrackNr = { bg = "NONE", fg = "#E02C6D" },
}

return {
    "lewis6991/gitsigns.nvim",
     event = "VeryLazy",
     opts = {
        signs = {
            add          = { hl = 'GitSignsAdd'   ,  text = '┃',  numhl = 'GitSignsAddNr'   ,  linehl = 'GitSignsAddLn'     },
            -- change       = { hl = 'GitSignsChange',  text = '╏',  numhl = 'GitSignsChangeNr',  linehl = 'GitSignsChangeLn'  },
            change       = { hl = 'GitSignsChange',  text = '┃',  numhl = 'GitSignsChangeNr',  linehl = 'GitSignsChangeLn'  },
            delete       = { hl = 'GitSignsDelete',  text = '⎽', numhl = 'GitSignsDeleteNr',  linehl = 'GitSignsDeleteLn'  },
            topdelete    = { hl = 'GitSignsDelete',  text = '⎺', numhl = 'GitSignsDeleteNr',  linehl = 'GitSignsDeleteLn'  },
            changedelete = { hl = 'GitSignsChange',  text = '',  numhl = 'GitSignsChangeNr',  linehl = 'GitSignsChangeLn'  },
            untracked    = { hl = 'GitSignsUntrack', text = '',  numhl = 'GitSignsUntrackNr', linehl = 'GitSignsUntrackLn' },
        },
        signcolumn = true,
        numhl      = false,
        linehl     = false,
        word_diff  = false,
        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        yadm = {
            enable = false
        },
        on_attach = function (bufnr)
            local gitsigns = package.loaded.gitsigns

            vim.keymap.set("n", "gj", gitsigns.next_hunk, { noremap = true })
            vim.keymap.set("n", "gk", gitsigns.prev_hunk, { noremap = true })
            vim.keymap.set("n", "gs", gitsigns.stage_buffer, { noremap = true })

            local api = vim.api
            api.nvim_set_keymap("x", "ih", ":<C-u>lua package.loaded.gitsigns.select_hunk()<CR>", { noremap = true })
            api.nvim_set_keymap("o", "ih", ":<C-u>lua package.loaded.gitsigns.select_hunk()<CR>", { noremap = true })

            -- require "UI.statusline".L2 = "%#statusLineL2# %{ b:gitsigns_status }"
        end,
        -- b:gitsigns_status
        status_formatter = function (status)
            local status_txt = {}
            
            local added   = status.added   or 0
            local changed = status.changed or 0
            local removed = status.removed or 0
            
            if added   > 0 then table.insert(status_txt, " %#GitSignsStatusLineAdd#+ "    .. added  ) end
            if changed > 0 then table.insert(status_txt, " %#GitSignsStatusLineChange#∙ " .. changed) end
            if removed > 0 then table.insert(status_txt, " %#GitSignsStatusLineDelete# " .. removed) end

            -- table.insert(status_txt, ' ')
            
            return table.concat(status_txt, '')

            -- local added   = status.added
            -- local changed = status.changed
            -- local removed = status.removed
            -- 
            -- local status = ''
            -- 
            -- if added   then status = status .. " %#GitSignsStatusLineAdd#+ "    .. added   end
            -- if changed then status = status .. " %#GitSignsStatusLineChange#∙ " .. changed end
            -- if removed then status = status .. " %#GitSignsStatusLineDelete#- " .. removed end
            -- 
            -- return status .. ' '
        end
     },
}
