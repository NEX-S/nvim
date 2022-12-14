
local M = {}

local bool_opts = {
    smartcase      = true,
    ignorecase     = true,
    hidden         = true,
    magic          = true,
    smarttab       = true,
    expandtab      = true,
    wildignorecase = true,
    smartindent    = true,
    startofline    = true,
    writeany       = true,
    undofile       = true,
    autochdir      = true,
    shiftround     = true,
    wrapscan       = true,
    confirm        = true, -- ???

    shiftround     = true, -- ?

    timeout       = false,
    ttimeout      = false,

    backup        = false,
    swapfile      = false,
    writebackup   = false,
    autoread      = false,
    autowrite     = false,
    warn          = false,
    loadplugins   = false,
}

local num_opts = {
    timeoutlen    = 0,
    ttimeoutlen   = 0,

    tabstop       = 4,
    softtabstop   = 4,
    shiftwidth    = 4, -- < / > lenth
    -- regexpengine  = 2,

    history       = 200,
    -- updatetime    = 4000,
}

local str_opts = {
    shadafile  = "",

    shell           = "fish",
    -- mouse           = "a",
    mouse           = "v",
    virtualedit     = "block",

    formatoptions   = "tcqjr",

    grepformat = "%f:%l:%c:%m,%f:%l:%m",
    grepprg    = "rg --vimgrep --no-heading --smart-case",

    -- matchpairs      = "(:),{:},[:],\":\",':',`:`",

    -- clipboard    = "unnamedplus", -- Bad Performance
    -- whichwrap       = "h,l,<,>,[,],~",
    -- grepformat   = '%f:%l:%c:%m,%f:%l:%m',
    -- grepprg      = 'rg --vimgrep --no-heading --smart-case',
    -- spelloptions = "camel",
}

function M.set_opts (table)
    local api = vim.api
    for key, value in pairs(table) do
        api.nvim_set_option_value(key, value, {})
    end
end

M.set_opts(bool_opts)
M.set_opts(num_opts)
M.set_opts(str_opts)

-- vim.defer_fn(function ()
--     vim.o.undofile = true -- Bad Startup performance
-- end, 300)

return M
