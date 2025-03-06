return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			---
			-- Global Config
			---
			local lspconfig = require("lspconfig")

			local lsp_defaults = {
				flags = {
					debounce_text_changes = 150,
				},
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(client, bufnr) end,
			}

			lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

			---
			-- Diagnostic Config
			---
			local sign = function(opts)
				vim.fn.sign_define(opts.name, {
					texthl = opts.name,
					text = opts.text,
					numhl = "",
				})
			end

			sign({ name = "DiagnosticSignError", text = "✘" })
			sign({ name = "DiagnosticSignWarn", text = "▲" })
			sign({ name = "DiagnosticSignHint", text = "⚑" })
			sign({ name = "DiagnosticSignInfo", text = "" })

			vim.diagnostic.config({
				severity_sort = true,
			})
		end,
		dependencies = {
			-- cmp-nvim-lsp is needed to update lsp client capabilities
			"hrsh7th/cmp-nvim-lsp",
			"mason.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("mason-lspconfig").setup({
						ensure_installed = {
							-- 'gopls',
							-- "basedpyright",
							"lua_ls",
							-- 'terraformls',
							-- "tsserver",
						},
					})

					----
					--- Automatic Language Server Setup
					----
					require("mason-lspconfig").setup_handlers({
						-- The first entry (without a key) will be the default handler
						-- and will be called for each installed server that doesn't have
						-- a dedicated handler.
						function(server_name) -- default handler (optional)
							require("lspconfig")[server_name].setup({})
						end,
						-- Next, you can provide a dedicated handler for specific servers.
						["lua_ls"] = function()
							require("lspconfig").lua_ls.setup({
								settings = {
									Lua = {
										runtime = {
											-- Tell the language server we are using LuaJIT in the case of Neovim
											version = "LuaJIT",
										},
										diagnostics = {
											-- Make the language server recognize the `vim` global
											globals = { "vim" },
										},
										workspace = {
											-- Make the server aware of Neovim runtime files
											library = { os.getenv("VIMRUNTIME") },
										},
										-- Do not send telemetry data containing a randomized but unique identifier
										telemetry = {
											enable = false,
										},
									},
								},
							})
						end,
						["jdtls"] = function()
							-- Skip auto configuration for jdtls,
							-- it should be configured via nvim-jdtls instead of lspconfig
							-- https://github.com/mfussenegger/nvim-jdtls#nvim-lspconfig-and-nvim-jdtls-differences
							-- Also, we need to setup jdtls via autocmd so it can be attached to new buffers correctly
						end,
						["eslint"] = function()
							require("lspconfig").eslint.setup({
								on_attach = function(client, bufnr)
									-- fix all on save
									vim.api.nvim_create_autocmd("BufWritePre", {
										buffer = bufnr,
										command = "EslintFixAll",
									})
								end,
							})
						end,
					})
				end,
			},
			{
				"glepnir/lspsaga.nvim",
				branch = "main",
				opts = {
					ui = {
						code_action = "",
					},
					-- jdtls is pretty slow
					request_timeout = 5000,
				},
			},
		},
	},
	{
		"mfussenegger/nvim-jdtls",
		-- We need to run the setup every time when a java file is opened
		-- to make sure the jdtls server is attached.
		-- However, load the plugin with ft = "java" will only load it once,
		-- so the setup is called in autocmds.lua with FileType event.
		-- Declaring the module is needed to ensure it can be loaded correctly.
		lazy = true,
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local fmt_group = vim.api.nvim_create_augroup("null-ls fmt_on_save", { clear = true })

			local function fmt_on_save(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						desc = "null-ls autoformat on save",
						group = fmt_group,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								timeout_ms = 3000,
								buffer = bufnr,
								filter = function(fClient)
									return fClient.name == "null-ls"
								end,
							})
						end,
					})
				end
			end

			-- Configuring null-ls
			return {
				sources = {
					-- Anything not supported by mason.
				},
				on_attach = function(client, bufnr)
					fmt_on_save(client, bufnr)
				end,
			}
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "black", "isort", "prettierd", "stylua" },
				handlers = {},
				-- This is for auto installing sources listed in the null-ls confs,
				-- which is an alternative way to configure sources.
				-- Probably better if most needed sources are not supported by mason.
				-- Not needed since all sources we need are supported by mason,
				-- so it's better to let mason-null-ls handle the installation (ensure_installed above)
				automatic_installation = false,
			})
		end,
	},
}
