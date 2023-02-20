require("mason-lspconfig").setup({
	ensure_installed = {
		-- 'gopls',
		-- "pyright",
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
})
