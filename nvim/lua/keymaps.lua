local set_map = vim.keymap.set

-- repeat a command-line command
set_map('n', '<leader>.', '@:', { noremap = true })
