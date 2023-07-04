local M = {}

function M.setup()
	-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local data_dir = vim.fn.stdpath("data")
	local workspace_dir = data_dir .. "/jdtls/" .. project_name

	local home = os.getenv("HOME")
	local jvm_dir = home .. "/jvm"

	-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
	local config = {
		-- The command that starts the language server
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = {

			jvm_dir .. "/java-17/bin/java", -- or '/path/to/java17_or_newer/bin/java'

			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xms1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",

			"-jar",
			data_dir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar",
			-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
			-- Must point to the                                                     Change this to
			-- eclipse.jdt.ls installation                                           the actual version

			"-configuration",
			data_dir .. "/mason/packages/jdtls/config_linux",
			-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
			-- Must point to the                      Change to one of `linux`, `win` or `mac`
			-- eclipse.jdt.ls installation            Depending on your system.

			-- See `data directory configuration` section in the README
			"-data",
			workspace_dir,
		},

		-- This is the default if not provided, you can remove it. Or adjust as needed.
		-- One dedicated LSP server & client will be started per unique root_dir
		root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {
				configuration = {
					runtimes = {
						{
							name = "JaveSE-1.8",
							path = jvm_dir .. "/java-8",
						},
						{
							name = "JavaSE-11",
							path = jvm_dir .. "/java-11",
						},
					},
				},
			},
		},

		-- Language server `initializationOptions`
		-- You need to extend the `bundles` with paths to jar files
		-- if you want to use additional eclipse.jdt.ls plugins.
		--
		-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = {},
		},
		on_attach = function(client, bufnr)
			require("jdtls.setup").add_commands()
		end,
	}
	-- This starts a new client & server,
	-- or attaches to an existing client & server depending on the `root_dir`.
	require("jdtls").start_or_attach(config)
end

return M
