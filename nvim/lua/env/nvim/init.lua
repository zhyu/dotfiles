local current_module = "env.nvim"

-- basic editor options
require(current_module .. ".basic")

-- plugins management and config
require(current_module .. ".lazyvim")

-- automatic commands
require(current_module .. ".autocmds")

-- custom keybindings
require(current_module .. ".keymaps")