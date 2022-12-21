
local opt = vim.o

local M = {}

local opts_bool = {
    smartcase      = true,
    ignorecase     = true,
    incsearch      = true,
    hidden         = true,
    magic          = true,
    smarttab       = true,
    expandtab      = true,
    wildignorecase = true,
    smartindent    = true,
    startofline    = true,
    writeany       = true,

    backup        = false,
    writebackup   = false,
    confirm       = false,
    autoread      = false,
    warn          = false,
    loadplugins   = false,
}

local opts_num = {
    tabstop       = 4,
    softtabstop   = 4,
    shiftwidth    = 4,
    -- regexpengine  = 2,

    history       = 200,
    -- updatetime    = 4000,
}

local opts_str = {

    shell           = "/bin/bash",
    mouse           = "a",
    virtualedit     = "block",

    formatoptions   = "tcqjr",

    -- matchpairs      = "(:),{:},[:],\":\",':',`:`",

    -- clipboard    = "unnamedplus", -- Bad Performance
    -- whichwrap       = "h,l,<,>,[,],~",
    -- grepformat   = '%f:%l:%c:%m,%f:%l:%m',
    -- grepprg      = 'rg --vimgrep --no-heading --smart-case',
    -- spelloptions = "camel",
}

function M.set_opts (table)
    local opt = vim.o
    for key, value in pairs(table) do
        opt[key] = value
    end
end

M.set_opts(opts_bool)
M.set_opts(opts_num)
M.set_opts(opts_str)

vim.defer_fn(function ()
    -- api.nvim_command "filetype on"
    opt.undofile = true -- Bad Startup performance
end, 300)

return M
