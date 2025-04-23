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
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {},
	},
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},
	{
		"ntpeters/vim-better-whitespace",
		event = { "BufReadPost", "BufNewFile" },
	},
	-- icons
	{ "kyazdani42/nvim-web-devicons", lazy = true },
}
