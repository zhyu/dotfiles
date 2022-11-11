require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "<leader>nh", function()
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Navigate to the next hunk" })

		map("n", "<leader>ph", function()
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Navigate to the previous hunk" })

		-- Actions
		map({ "n", "v" }, "<leader>hs", gs.stage_hunk, { desc = "Stage the hunk under the cursor" })
		map({ "n", "v" }, "<leader>hr", gs.reset_hunk, { desc = "Reset the hunk under the cursor" })
		map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage the current buffer" })
		map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset the current buffer" })
		map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo the staging of the hunk under the cursor" })
		map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview the diff of the hunk under the cursor" })
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "Preview the blame of the curent line" })
		map(
			"n",
			"<leader>tb",
			gs.toggle_current_line_blame,
			{ desc = "Toggle the preview of the current line using virtual text" }
		)
		map("n", "<leader>hd", gs.diffthis, { desc = "Diff against the index" })
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "Diff against the last commit" })
		map(
			"n",
			"<leader>td",
			gs.toggle_deleted,
			{ desc = "Toggle the display of the old version of hunks using the virtual text" }
		)
	end,
})
