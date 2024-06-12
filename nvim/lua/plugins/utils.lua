return {
	{
		"ggandor/leap.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local leap = require("leap")

			leap.add_default_mappings()
			leap.add_repeat_mappings(";", ",", {
				-- False by default. If set to true, the keys will work like the
				-- native semicolon/comma, i.e., forward/backward is understood in
				-- relation to the last motion.
				relative_directions = true,
				-- By default, all modes are included.
				modes = { "n", "x", "o" },
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},
	{ "johmsalas/text-case.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },
	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
}
