return {
	{
		"ggandor/leap.nvim",
		event = "BufRead",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = true,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},
	{
		"tpope/vim-abolish",
		event = "BufRead",
	},
	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
}
