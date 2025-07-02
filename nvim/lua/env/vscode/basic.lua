local set = vim.opt
local g = vim.g

-- enable timeout for mapped sequences and key code sequences
set.timeout = true
-- wait 500 ms for a mapped sequence
set.timeoutlen = 500
-- wait 10 ms for a key code sequence
set.ttimeoutlen = 10

-- <Space> as <Leader>
g.mapleader = " "
