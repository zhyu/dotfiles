local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			vertical = { width = 0.66 },
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})

local set_map = vim.keymap.set
local opts = { noremap = true }

set_map("n", "<leader>F", function()
	require("telescope.builtin").builtin()
end, opts)
set_map("n", "<leader>fp", function()
	require("telescope.builtin").resume()
end, opts)
set_map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, opts)
set_map("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, opts)
set_map("n", "<leader>fw", function()
	require("telescope.builtin").grep_string()
end, opts)
set_map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, opts)
set_map("n", "<leader>fs", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end, opts)
set_map("n", "<leader>fcm", function()
	require("telescope.builtin").commands()
end, opts)
set_map("n", "<leader>g", function()
	require("telescope.builtin").git_status()
end, opts)
