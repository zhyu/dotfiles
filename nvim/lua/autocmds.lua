local create_augrp = vim.api.nvim_create_augroup
local create_aucmd = vim.api.nvim_create_autocmd

local common_grp = create_augrp("common", { clear = true })
-- tab indentation for Golang
create_aucmd("FileType", { pattern = "go", command = "setlocal noet", group = common_grp })
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
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Displays hover information about the symbol under the cursor
		-- bufmap("n", "K", function() vim.lsp.buf.hover() end)
		bufmap("n", "K", function()
			require("lspsaga.hover").render_hover_doc()
		end)

		-- Jump to the definition
		bufmap("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end)

		-- Preview definition
		bufmap("n", "gD", function()
			require("lspsaga.definition").preview_definition()
		end)

		-- Jump to declaration
		-- bufmap("n", "gD", function() vim.lsp.buf.declaration() end)

		-- Lists all the implementations for the symbol under the cursor
		bufmap("n", "gi", function()
			require("telescope.builtin").lsp_implementations()
		end)

		-- Jumps to the definition of the type symbol
		bufmap("n", "gy", function()
			require("telescope.builtin").lsp_type_definitions()
		end)

		-- Lists all the references
		bufmap("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end)

		-- Displays a function's signature information
		-- bufmap("n", "<C-k>", function() vim.lsp.buf.signature_help() end)
		bufmap("n", "<C-k>", function()
			require("lspsaga.signaturehelp").signature_help()
		end)

		-- Renames all references to the symbol under the cursor
		bufmap("n", "<Leader>rn", function()
			require("lspsaga.rename").lsp_rename()
		end)

		-- Selects a code action available at the current cursor position
		-- bufmap("n", "<Leader>ac", function() vim.lsp.buf.code_action() end)
		-- bufmap("x", "<Leader>ac", function() vim.lsp.buf.range_code_action() end)
		bufmap("n", "<Leader>ac", function()
			require("lspsaga.codeaction").code_action()
		end)
		bufmap("x", "<Leader>ac", function()
			require("lspsaga.codeaction").range_code_action()
		end)

		-- Show diagnostics in a floating window
		-- bufmap("n", "gl", function() vim.diagnostic.open_float() end)
		bufmap("n", "gl", function()
			require("lspsaga.diagnostic").show_line_diagnostics()
		end)
		bufmap("n", "gc", function()
			require("lspsaga.diagnostic").show_cursor_diagnostics()
		end)

		-- List all diagnostics for the current buffer
		bufmap("n", "<Leader>fd", function()
			require("telescope.builtin").diagnostics({ bufnr = 0 })
		end)

		-- List all diagnostics for all open buffers
		bufmap("n", "<Leader>fD", function()
			require("telescope.builtin").diagnostics()
		end)

		-- Move to the previous diagnostic
		-- bufmap("n", "<Leader>pd", function() vim.diagnostic.goto_prev() end)
		bufmap("n", "<Leader>pd", function()
			require("lspsaga.diagnostic").goto_prev()
		end)

		-- Move to the next diagnostic
		-- bufmap("n", "<Leader>nd", function() vim.diagnostic.goto_next() end)
		bufmap("n", "<Leader>nd", function()
			require("lspsaga.diagnostic").goto_next()
		end)

		-- Scroll down hover doc or scroll in definition preview
		bufmap("n", "<C-f>", function()
			require("lspsaga.action").smart_scroll_with_saga(1)
		end)

		-- Scroll up hover doc or scroll in definition preview
		bufmap("n", "<C-b>", function()
			require("lspsaga.action").smart_scroll_with_saga(-1)
		end)
	end,
})
