local create_augrp = vim.api.nvim_create_augroup
local create_aucmd = vim.api.nvim_create_autocmd

local common_grp = create_augrp("common", { clear = true })
-- tab indentation for Golang
create_aucmd("FileType", { pattern = "go", command = "setlocal noet", group = common_grp })
-- setup jdtls for Java
create_aucmd("FileType", {
	pattern = "java",
	callback = function()
		require("plugins.lsp.jdtls").setup()
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

local user_lsp_config_grp = create_augrp("user_lsp_config", { clear = true })

-- Set keybindings on LspAttach
create_aucmd("LspAttach", {
	desc = "Set keybindings on LspAttach",
	group = user_lsp_config_grp,
	callback = function()
		local bufmap = function(mode, lhs, rhs, desc)
			local opts = { buffer = true, desc = desc }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		bufmap("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Display hover information about the symbol under the cursor")

		bufmap("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end, "Jump to the definition")

		bufmap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", "Find definitions, implementations, and references")

		bufmap("n", "gi", function()
			require("telescope.builtin").lsp_implementations()
		end, "List all the implementations")

		bufmap("n", "gy", function()
			require("telescope.builtin").lsp_type_definitions()
		end, "Jump to the definition of the type symbol")

		bufmap("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, "List all the references")

		bufmap("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>", "Rename all references to the symbol under the cursor")

		bufmap(
			"n",
			"<Leader>ac",
			"<cmd>Lspsaga code_action<CR>",
			"Select a code action available at the current cursor position"
		)
		bufmap(
			"x",
			"<Leader>ac",
			"<cmd>Lspsaga code_action<CR>",
			"Select a code action available at the current cursor position"
		)

		bufmap(
			"n",
			"gl",
			"<cmd>Lspsaga show_line_diagnostics<CR>",
			"Show diagnostics of the current line in a floating window"
		)
		-- gc is used to toggle comments, so use gp (point/position) instead
		bufmap(
			"n",
			"gp",
			"<cmd>Lspsaga show_cursor_diagnostics<CR>",
			"Show diagnostics of the current cursor position in a floating window"
		)

		bufmap("n", "<Leader>fd", function()
			require("telescope.builtin").diagnostics({ bufnr = 0 })
		end, "List all diagnostics for the current buffer")

		bufmap("n", "<Leader>fD", function()
			require("telescope.builtin").diagnostics()
		end, "List all diagnostics for all open buffers")

		bufmap("n", "<Leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Move to the previous diagnostic")

		bufmap("n", "<Leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Move to the next diagnostic")
	end,
})

-- Lsp autoformat on save
create_aucmd("LspAttach", {
	desc = "Lsp autoformat on save",
	group = user_lsp_config_grp,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.name == "terraformls" then
			local bufnr = args.buf
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						timeout_ms = 3000,
						buffer = bufnr,
						filter = function(c)
							return c.name == "terraformls"
						end,
					})
				end,
			})
		end
	end,
})
