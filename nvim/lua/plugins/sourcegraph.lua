return {
	{
		"sourcegraph/sg.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- only load when SRC_ENDPOINT and SRC_ACCESS_TOKEN are set
		cond = vim.env.SRC_ENDPOINT ~= nil and vim.env.SRC_ACCESS_TOKEN ~= nil,
		event = "VeryLazy",
		config = true,
	},
}
