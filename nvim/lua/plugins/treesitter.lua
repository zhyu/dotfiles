return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"css",
					"go",
					"gomod",
					"html",
					"json",
					"java",
					"javascript",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"terraform",
					"typescript",
					"vim",
					"yaml",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = false,
				},
				autotag = {
					enable = true,
				},
			})
		end,
		dependencies = {
			{ "windwp/nvim-ts-autotag" },
			{
				"https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
				config = function()
					-- This module contains a number of default definitions
					local rainbow_delimiters = require("rainbow-delimiters")

					vim.g.rainbow_delimiters = {
						strategy = {
							[""] = rainbow_delimiters.strategy["global"],
							vim = rainbow_delimiters.strategy["local"],
						},
						query = {
							[""] = "rainbow-delimiters",
							lua = "rainbow-blocks",
						},
						highlight = {
							"RainbowDelimiterRed",
							"RainbowDelimiterYellow",
							"RainbowDelimiterBlue",
							"RainbowDelimiterOrange",
							"RainbowDelimiterGreen",
							"RainbowDelimiterViolet",
							"RainbowDelimiterCyan",
						},
					}
				end,
			},
		},
	},
}
