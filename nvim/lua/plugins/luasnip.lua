-- Loading any vscode style snippets from plugins
require("luasnip.loaders.from_vscode").lazy_load()

-- Mappings to move around inside snippets
vim.keymap.set("i", "<C-j>", function()
	require("luasnip").jump(1)
end)
vim.keymap.set("i", "<C-k>", function()
	require("luasnip").jump(-1)
end)
vim.keymap.set("s", "<C-j>", function()
	require("luasnip").jump(1)
end)
vim.keymap.set("s", "<C-k>", function()
	require("luasnip").jump(-1)
end)
