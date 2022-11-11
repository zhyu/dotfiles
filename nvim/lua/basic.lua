local set = vim.opt
local g = vim.g

-- string encoding used internally and for RPC communication
set.encoding = "utf-8"
-- file-content encoding
set.fileencoding = "utf-8"

-- true color
set.termguicolors = true

-- display line number
set.number = true
-- display relative line number
set.relativenumber = true
-- allow keeping modified buffers in background
set.hidden = true
-- display tab, eol as defined in `listchars`
set.list = true
-- set characters to be displayed for invisible characters
set.listchars = "tab:| ,eol:↴"
-- alway draw the signcolumn to display signs, avoid shifting the number column
set.signcolumn = "yes"

-- don't keep backup files
set.backup = false
-- don't keep backup files when writing
set.writebackup = false

-- ignore case in search patterns
set.ignorecase = true
-- override ignorecase when the search pattern contains upper case characters
set.smartcase = true
-- incremental search
set.incsearch = true

-- allow backspacing over autoindent, line breaks, and the start of insert
set.backspace = "indent,eol,start"
-- use the appropriate number of spaces to insert a <Tab>
set.expandtab = true
-- respect 'shiftwidth' when inserting/deleting a <Tab>
set.smarttab = true
-- number of spaces for a level of indentation
set.shiftwidth = 4
-- number of spaces for a '\t' character
set.tabstop = 4
-- number of spaces for a <Tab> keypress or a <BS> keypress
set.softtabstop = 4

-- folding based on 'foldexpr'
set.foldmethod = "expr"
-- treesitter based folding
set.foldexpr = "nvim_treesitter#foldexpr()"
-- hide folds with level higher than 99, i.e., expand all folds by default
set.foldlevel = 99

-- enable timeout for mapped sequences and key code sequences
set.timeout = true
-- wait 500 ms for a mapped sequence
set.timeoutlen = 500
-- wait 10 ms for a key code sequence
set.ttimeoutlen = 10

-- trigger CursorHold event when no keys are pressed for 300 ms
set.updatetime = 300

-- completion menu setup suggested by nvim-cmp
set.completeopt = { "menu", "menuone", "noselect" }

-- disable node provider
g.loaded_node_provider = 0
-- disable ruby provider
g.loaded_ruby_provider = 0
-- disable perl provider
g.loaded_perl_provider = 0
-- disable python 2 provider
g.loaded_python_provider = 0
-- disable python 3 provider
g.loaded_python3_provider = 0

-- <Space> as <Leader>
g.mapleader = " "
