return {
	{
		"mason-org/mason.nvim",
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
			vim.diagnostic.config({
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "⚑",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
			})
		end,
		dependencies = {
			-- cmp-nvim-lsp is needed to update lsp client capabilities
			"hrsh7th/cmp-nvim-lsp",
			"mason.nvim",
			{
				"mason-org/mason-lspconfig.nvim",
				config = function()
					require("mason-lspconfig").setup({
						ensure_installed = {
							-- 'gopls',
							-- "basedpyright",
							"lua_ls",
							-- 'terraformls',
							-- "tsserver",
						},
						automatic_enable = {
							exclude = {
								"jdtls", -- jdtls is handled by nvim-jdtls plugin
							},
						},
					})

					vim.lsp.config("lua_ls", {
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
					vim.lsp.config("eslint", {
						on_attach = function(client, bufnr)
							local au_group = vim.api.nvim_create_augroup("eslint fix_all_on_save", { clear = true })
							vim.api.nvim_create_autocmd("BufWritePre", {
								desc = "Eslint fix all on save",
								group = au_group,
								buffer = bufnr,
								callback = function()
									require("plugins.nvim.lsp.actions").fix_all_sync(client, bufnr)
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
			local function fmt_on_save(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					local fmt_group = vim.api.nvim_create_augroup("null-ls fmt_on_save", { clear = true })
					vim.api.nvim_create_autocmd("BufWritePre", {
						desc = "null-ls autoformat on save",
						group = fmt_group,
						buffer = bufnr,
						callback = function()
							require("plugins.nvim.lsp.actions").format_sync(client, bufnr)
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
				ensure_installed = { "black", "isort", "stylua" },
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
