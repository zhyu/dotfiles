return {
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			tabline = {
				lualine_a = { "buffers" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "lazy" },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		opts = {
			show_end_of_line = true,
		},
	},
	{
		"ntpeters/vim-better-whitespace",
		event = "BufRead",
	},
	-- icons
	{ "kyazdani42/nvim-web-devicons", lazy = true },
}
