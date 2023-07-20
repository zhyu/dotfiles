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
		"tpope/vim-surround",
		event = "BufRead",
		dependencies = {
			{
				"tpope/vim-repeat",
				event = "BufRead",
			},
		},
	},
	{
		"tpope/vim-abolish",
		event = "BufRead",
	},
	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
}
