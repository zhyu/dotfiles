vim.loader.enable()

if vim.g.vscode then
	-- VSCode extension
	require("lazyvim")
else
	-- basic editor options
	require("basic")

	-- plugins management and config
	require("lazyvim")

	-- automatic commands
	require("autocmds")

	-- custom keybindings
	require("keymaps")
end
