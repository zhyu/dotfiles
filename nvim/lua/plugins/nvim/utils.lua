return {
	{ "johmsalas/text-case.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },
	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
}
