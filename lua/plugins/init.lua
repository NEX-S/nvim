
vim.defer_fn(function ()
    require "plugins.comments"
    require "plugins.fcitx"
    require "plugins.auto-pair"
    require "plugins.translate"
    require "plugins.complete"
    require "plugins.run-code"
    require "plugins.match"
    require "plugins.align"
    require "plugins.file-explorer"

    require "plugins.surround"

end, 150)

