local config_path = vim.fn.stdpath('config')
local cmd = vim.cmd

-- basic editor options
require('basic')

-- plugins management and config
require('plugins')

-- autocmd and commands in vimscript
cmd('source ' .. config_path .. '/commands.vim')

-- functions in vimscript
cmd('source ' .. config_path .. '/functions.vim')

-- key mappings in vimscript
cmd('source ' .. config_path .. '/keymaps.vim')
