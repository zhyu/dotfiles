local config_path = vim.fn.stdpath('config')
local cmd = vim.cmd

-- basic editor options
require('basic')

-- plugins management and config
require('plugins')

-- autocmd and commands in vimscript
cmd('source ' .. config_path .. '/vimscript/commands.vim')

-- key mappings in vimscript
cmd('source ' .. config_path .. '/vimscript/keymaps.vim')
