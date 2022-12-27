-- @@ repeat last macro 
local api = vim.api

-- vim.keymap.set("n", ".", function ()
--     return vim.fn.getreg("l") == "" and "." or "@l"
-- end, { expr = true })

-- api.nvim_create_autocmd("InsertLeave", {
--     command = "call setreg('l', '')"
-- })

api.nvim_set_keymap("n", "<C-m>", "ql", { noremap = true })
api.nvim_set_keymap("n", "<CR>", "@l|j", { noremap = true })

-- vim.keymap.set("n", "<C-m>", function ()
--     print("LINE RECORDING")
--     api.nvim_command("normal!ql")
-- end)

