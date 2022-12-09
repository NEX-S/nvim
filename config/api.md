
## MISC

```
api.nvim_win_get_cursor(0)  -> { line_num, column_num }
api.nvim_get_current_line() -> Get cursorline string
vim.fn.getline(".")         -> Get cursorline string
vim.fn.bufnr("%")           -> Get Current buffer number
```

## Function


> fn.getpos
```text
[ .  ]  -> { 0, cursor_line, cursor_column, 0 }
[ w0 ]  -> { 0, win_top_line, ?, 0 }

```
-> 

> fn.timer_start
```
-- Delay 1s call function ()
vim.fn.timer_start(1000, function ()
    print "Hello"
end)
```

## API

> api.nvim_buf_set_lines()
```
[ INTRODUCTION ]
----------------------------------------------------------------------
Replace line { start } - { end } to { replacement }

Parameters:
  • { buffer }           Buffer handle, or 0 for current buffer
  • { start }            First line index
  • { end }              Last line index, exclusive must larger than { start }
  • { strict_indexing }  Whether out-of-bounds should be an error.
  • { replacement }      Array of lines to use as replacement

[ EXANPLE ]
----------------------------------------------------------------------

Replace line 4 to "HelloWorld"
    api.nvim_buf_set_lines(0, 3, 4, false, { "HelloWorld" })

Insert "HelloWorld" into line 3 - 4
    api.nvim_buf_set_lines(0, 3, 3, false, { "HelloWorld" })

```

> api.nvim_buf_set_text()
```
[ INTRODUCTION ]
----------------------------------------------------------------------
Replace content from line { start_line } to { end_line } and column { start_col } to { end_col }

    Parameters:
      • { buffer }       Buffer handle, or 0 for current buffer
      • { start_line }   First line index
      • { start_col }    Starting column (byte offset) on first line
      • { end_line }     Last line index, inclusive
      • { end_col }      Ending column (byte offset) on last line, exclusive
      • { replacement }  Array of lines to use as replacement

[ EXANPLE ]
----------------------------------------------------------------------
Insert "HelloWorld" to line 51 col 10
lua vim.api.nvim_buf_set_text(0, 50, 10, 50, 10, { "HelloWorld" })

Replace line 52 to "Hello"
api.nvim_buf_set_text(0, 52, 0, 52, line_length, { "Hello" })
```

> api.nvim_win_set_cursor()
```
[ INTRODUCTION ]
----------------------------------------------------------------------
Sets the (1,0)-indexed cursor position in the window. |api-indexing| This
scrolls the window even if it is not the current one.

Parameters:
  • { window } : integer   Window number, 0 for current window
  • { pos }    : table     New position { row, col }

[ EXANPLE ]
----------------------------------------------------------------------
Set cursor position to line 11 column 3 in current window
api.nvim_win_get_cursor(0, { 11, 3 })

Set cursor position to line 87 column 3
api.nvim_win_set_cursor(0, { 87, 3 })
```

### api.nvim_buf_set_extmark

> Creates or updates an extmark.
```
api.nvim_buf_set_extmark({ buffer }, { ns_id }, { line }, { col }, { *opts })

Return:
    Id of the created/updated extmark

[ EXANPLE ] 
----------------------------------------------------------------------
local api = vim.api

local bufnr = vim.fn.bufnr("%")
local ns_id = api.nvim_create_namespace("demo_ns")

local opts = {
    virt_text = {
        { "HelloNEX", "hl_group" },
    }
}

-- "HelloNEX" in { line:10 } { column:10 }
api.nvim_buf_set_extmark(bufnr, ns_id, 10, 0, opts)
```

### api.nvim_buf_del_extmark

> Removes an extmark.
```
api.nvim_buf_del_extmark({ buffer }, { ns_id }, { virt_id })

[ EXANPLE ] 
----------------------------------------------------------------------
local api = vim.api

local bufnr = vim.fn.bufnr("%")
local ns_id = api.nvim_create_namespace("demo_ns")

local opts = {
    id = 1,
    virt_text = {
        { "HelloNEX", "IncSearch" },
    }
}

api.nvim_buf_set_extmark(bufnr, ns_id, 10, 0, opts)

-- Delete { line:10 } { column:0 } "HelloNEX" in 3 seconds
vim.fn.timer_start(3000, function ()
    api.nvim_buf_del_extmark(bufnr, ns_id, opts.id)
end)
```
