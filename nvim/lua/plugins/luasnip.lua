-- Loading any vscode style snippets from plugins
require("luasnip.loaders.from_vscode").lazy_load()

local set_map = function(mode, lhs, rhs, desc)
	local opts = { desc = desc }
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Mappings to move around inside snippets
set_map("i", "<C-j>", function()
	require("luasnip").jump(1)
end, "Jump to next position inside the snippet")
set_map("i", "<C-k>", function()
	require("luasnip").jump(-1)
end, "Jump to previous position inside the snippet")
set_map("s", "<C-j>", function()
	require("luasnip").jump(1)
end, "Jump to next position inside the snippet")
set_map("s", "<C-k>", function()
	require("luasnip").jump(-1)
end, "Jump to previous position inside the snippet")
