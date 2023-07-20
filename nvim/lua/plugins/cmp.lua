local cmp = require("cmp")
-- Insert the completion candidate on select
local select_opts = { behavior = cmp.SelectBehavior.Insert }

local kind_icon = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

local menu_icon = {
	nvim_lsp = "λ",
	luasnip = "⋗",
	buffer = "﬘",
	path = "",
	copilot = "",
	cmp_tabnine = "",
}

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "copilot" },
		{ name = "nvim_lsp", max_item_count = 5 },
		{ name = "cmp_tabnine" },
		{ name = "luasnip", max_item_count = 5, keyword_length = 2 },
	}, {
		{ name = "path", max_item_count = 5 },
		{ name = "buffer", max_item_count = 5 },
	}),
	-- Sometimes, lsp would suggest an item to be preselected. The item could be
	-- in the middle of the list, which makes it harder to navigate to the first
	-- item and makes the sources order useless.
	preselect = cmp.PreselectMode.None,
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			-- Kind icons
			item.kind = string.format("%s %s", kind_icon[item.kind], item.kind)
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),

		["<C-j>"] = cmp.mapping(function(fallback)
			local luasnip = require("luasnip")
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-k>"] = cmp.mapping(function(fallback)
			local luasnip = require("luasnip")
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			-- local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			-- it seems I rarely use <Tab> for indentation.
			--[[ elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback() ]]
			else
				cmp.complete()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})
