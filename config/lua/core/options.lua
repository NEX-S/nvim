
local opt = vim.o

-- local plugin_list = {
--     "2html_plugin",
--     "getscript",
--     "getscriptPlugin",
--     "gzip",
--     "logiPat",
--     "matchit",
--     "matchparen",
--     "netrw",
--     "netrwFileHandlers",
--     "netrwPlugin",
--     "netrwSettings",
--     "remote_plugins",
--     "rrhelper",
--     "shada_plugin",
--     "spellfile_plugin",
--     "tar",
--     "tarPlugin",
--     "tutor_mode_plugin",
--     "vimball",
--     "vimballPlugin",
--     "zip",
--     "zipPlugin",
-- }
--
-- for i = 1, #plugin_list do
--     vim.g['loaded_' .. plugin_list[i]] = true
-- end

local opts_bool = {
    smartcase      = true,
    ignorecase     = true,
    incsearch      = true,
    wrap           = true,
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
    wrap          = false,
    warn          = false,
    loadplugins   = false,
}

local opts_num = {
    tabstop       = 4,
    softtabstop   = 4,
    shiftwidth    = 4,
    -- regexpengine  = 2,

    history       = 200,
    updatetime    = 4000,
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

local function set_opt (table)
    local opt = vim.o
    for key, value in pairs(table) do
        opt[key] = value
    end
end

set_opt(opts_bool)
set_opt(opts_num)
set_opt(opts_str)

vim.defer_fn(function ()
    -- vim.cmd "filetype on"
    opt.undofile = true -- Bad Startup performance
end, 300)

