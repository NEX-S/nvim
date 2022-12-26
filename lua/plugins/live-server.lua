
vim.keymap.set("n", ";r", function ()
    vim.loop.new_thread(function ()
        os.execute("live-server /home/nex/test.html")
    end)
end)
