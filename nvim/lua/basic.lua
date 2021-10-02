local set = vim.opt
local g = vim.g

set.encoding = 'utf-8'             --
set.fileencoding = 'utf-8'         --

set.termguicolors = true           -- true color

set.number = true                  -- display line number
set.hidden = true                  -- allow keeping modified buffers in background
set.list = true                    -- display tab, eol as defined in `listchars`
set.listchars = 'tab:| ,eol:↴'     --
set.cmdheight = 2                  -- give command line more space to display messages
set.signcolumn = 'number'          -- display signs in the number column, avoid shifting line numbers

set.backup = false                 -- don't keep backup files
set.writebackup = false            -- don't keep backup files when writing

set.ignorecase = true              -- ignore case in search patterns
set.smartcase = true               -- override ignorecase when the search pattern contains upper case characters
set.incsearch = true               -- incremental search

set.backspace = 'indent,eol,start' -- allow backspacing over autoindent, line breaks, and the start of insert
set.expandtab = true               -- use the appropriate number of spaces to insert a <Tab>
set.smarttab = true                -- respect 'shiftwidth' when inserting/deleting a <Tab>
set.shiftwidth = 2                 --
set.tabstop = 2                    --
set.softtabstop = 2                --

set.foldmethod = 'indent'          -- fold based on indent
set.foldlevel = 99                 -- hide folds with level higher than 99, i.e., expand all folds by default

set.timeout = true                 --
set.timeoutlen = 500               -- wait 500 ms for a mapped sequence
set.ttimeoutlen = 10               -- wait 10 ms for a key code sequence

set.updatetime = 300               -- trigger CursorHold event when no keys are pressed for 300 ms

set.shortmess:append('c')          -- Don't pass messages to |ins-completion-menu|.

g.loaded_node_provider = 0         -- disable node provider
g.loaded_ruby_provider = 0         -- disable ruby provider
g.loaded_perl_provider = 0         -- disable perl provider
g.loaded_python_provider = 0       -- disable python 2 provider
g.loaded_python3_provider = 0      -- disable python 3 provider

g.mapleader = " "                  -- <Space> as <Leader>
