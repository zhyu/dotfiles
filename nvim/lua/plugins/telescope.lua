return {
	{
		"nvim-telescope/telescope.nvim",
		opts = function()
			local actions = require("telescope.actions")
			return {
				defaults = {
					-- Build a custom dropdown theme with the `vertical` layout strategy.
					-- Unlike the builtin dropdown theme, which is based on the `center` layout strategy,
					-- using the `vertical` layout strategy allows showing more lines in the preview window.
					results_title = false,
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						vertical = { width = 0.85, height = 0.9, preview_cutoff = 1, prompt_position = "top" },
					},
					border = true,
					borderchars = {
						prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
						results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
						preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					},
					--- end of custom theme
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
				},
			}
		end,
		keys = {
			{
				"<leader>F",
				function()
					require("telescope.builtin").builtin()
				end,
				desc = "Find Telescope builtin commands",
			},
			{
				"<leader>fp",
				function()
					require("telescope.builtin").resume()
				end,
				desc = "Resume last Telescope search",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffers",
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "Find word under the cursor in files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Grep in files",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Search text in the current buffer",
			},
			{
				"<leader>fcm",
				function()
					require("telescope.builtin").commands()
				end,
				desc = "Find vim commands",
			},
			{
				"<leader>g",
				function()
					require("telescope.builtin").git_status()
				end,
				desc = "Find changed files in git",
			},
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
			-- load treesitter for previewing
			{ "nvim-treesitter" },
		},
	},
}
