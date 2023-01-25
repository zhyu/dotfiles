local create_augrp = vim.api.nvim_create_augroup
local create_aucmd = vim.api.nvim_create_autocmd

local common_grp = create_augrp("common", { clear = true })
-- tab indentation for Golang
create_aucmd("FileType", { pattern = "go", command = "setlocal noet", group = common_grp })
-- setup jdtls for Java
create_aucmd("FileType", {
	pattern = "java",
	callback = function()
		require("plugins.jdtls").setup()
	end,
	group = common_grp,
})
-- Fix No Folds Found for files opened with telescope when using treesitter based folding
-- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-1074076011
create_aucmd("BufRead", {
	callback = function()
		create_aucmd("BufWinEnter", { command = "normal! zx", once = true })
	end,
	group = common_grp,
})

-- Set keybindings on LspAttached
create_aucmd("User", {
	pattern = "LspAttached",
	desc = "Set keybindings on LspAttached",
	callback = function()
		local bufmap = function(mode, lhs, rhs, desc)
			local opts = { buffer = true, desc = desc }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		bufmap("n", "K", function()
			require("lspsaga.hover").render_hover_doc()
		end, "Display hover information about the symbol under the cursor")

		bufmap("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end, "Jump to the definition")

		bufmap("n", "gf", function()
			require("lspsaga.finder"):lsp_finder()
		end, "Find definitions, implementations, and references")

		bufmap("n", "gi", function()
			require("telescope.builtin").lsp_implementations()
		end, "List all the implementations")

		bufmap("n", "gy", function()
			require("telescope.builtin").lsp_type_definitions()
		end, "Jump to the definition of the type symbol")

		bufmap("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, "List all the references")

		bufmap("n", "gs", function()
			require("lspsaga.signaturehelp").signature_help()
		end, "Display a function's signature information")

		bufmap("n", "<Leader>rn", function()
			require("lspsaga.rename"):lsp_rename()
		end, "Rename all references to the symbol under the cursor")

		bufmap("n", "<Leader>ac", function()
			require("lspsaga.codeaction"):code_action()
		end, "Select a code action available at the current cursor position")
		bufmap("x", "<Leader>ac", function()
			require("lspsaga.codeaction"):range_code_action()
		end, "Select a code action available at the current cursor position")

		bufmap("n", "gl", function()
			require("lspsaga.diagnostic"):show_diagnostics("", "line")
		end, "Show diagnostics of the current line in a floating window")
		-- gc is used to toggle comments, so use gp (point/position) instead
		bufmap("n", "gp", function()
			require("lspsaga.diagnostic"):show_diagnostics("", "cursor")
		end, "Show diagnostics of the current cursor position in a floating window")

		bufmap("n", "<Leader>fd", function()
			require("telescope.builtin").diagnostics({ bufnr = 0 })
		end, "List all diagnostics for the current buffer")

		bufmap("n", "<Leader>fD", function()
			require("telescope.builtin").diagnostics()
		end, "List all diagnostics for all open buffers")

		bufmap("n", "<Leader>pd", function()
			require("lspsaga.diagnostic"):goto_prev()
		end, "Move to the previous diagnostic")

		bufmap("n", "<Leader>nd", function()
			require("lspsaga.diagnostic"):goto_next()
		end, "Move to the next diagnostic")
	end,
})
