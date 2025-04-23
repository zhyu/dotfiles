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
					"regex",
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
			})
		end,
	},
	{ "windwp/nvim-ts-autotag", opts = {} },
	{
		"https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
		config = function()
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = "rainbow-delimiters.strategy.global",
					vim = "rainbow-delimiters.strategy.local",
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
	{
		"bennypowers/nvim-regexplainer",
		config = true,
		keys = {
			-- the default keybinding
			"gR",
		},
		cmd = {
			-- in case the popup doesn't have enough space
			"RegexplainerShowSplit",
		},
		dependencies = {
			"nvim-treesitter",
			"MunifTanjim/nui.nvim",
		},
	},
}
