return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		opts = function()
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
				buffer = "",
				path = "",
				copilot = "",
				cmp_tabnine = "󰌒",
			}

			return {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "copilot", priority = 100 },
					{ name = "nvim_lsp", max_item_count = 5, priority = 100 },
					{ name = "cmp_tabnine", max_item_count = 2 },
					{ name = "luasnip", max_item_count = 5, keyword_length = 2 },
				}, {
					{ name = "path", max_item_count = 3 },
					{ name = "buffer", max_item_count = 3 },
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
			}
		end,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				-- event = "InsertEnter",
				config = function()
					-- Loading any vscode style snippets from plugins
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
				requires = {
					{
						"rafamadriz/friendly-snippets",
						-- event = "InsertEnter",
					},
				},
				keys = {
					{
						"<C-j>",
						function()
							require("luasnip").jump(1)
						end,
						"i",
						desc = "Jump to next position inside the snippet",
					},
					{
						"<C-k>",
						function()
							require("luasnip").jump(-1)
						end,
						"i",
						desc = "Jump to previous position inside the snippet",
					},
					{
						"<C-j>",
						function()
							require("luasnip").jump(1)
						end,
						"s",
						desc = "Jump to next position inside the snippet",
					},
					{
						"<C-k>",
						function()
							require("luasnip").jump(-1)
						end,
						"s",
						desc = "Jump to previous position inside the snippet",
					},
				},
			},
			{
				"zbirenbaum/copilot-cmp",
				config = true,
				dependencies = {
					{
						"zbirenbaum/copilot.lua",
						event = "VeryLazy",
						config = function()
							vim.defer_fn(function()
								require("copilot").setup()
							end, 100)
						end,
					},
				},
			},
			{ "tzachar/cmp-tabnine", build = "./install.sh" },
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{
				"windwp/nvim-autopairs",
				event = "InsertCharPre",
				config = function()
					require("nvim-autopairs").setup()
					-- integration with nvim-cmp
					---@diagnostic disable-next-line: different-requires
					require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
				end,
			},
		},
	},
}
