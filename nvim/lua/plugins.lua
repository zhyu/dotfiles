-- ensure packer.nvim is installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

-- use plugins
require("packer").startup(function(use)
	-- packer itself
	use("wbthomason/packer.nvim")
	-- Load only when require
	use({ "nvim-lua/plenary.nvim", module = "plenary" })
	use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })
	-- UI
	use({
		{
			"nvim-treesitter/nvim-treesitter",
			event = "BufReadPre",
			run = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"bash",
						"css",
						"go",
						"gomod",
						"hcl",
						"html",
						"json",
						"java",
						"javascript",
						"lua",
						"python",
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
					rainbow = {
						enable = true,
						extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
						max_file_lines = nil, -- Do not enable for files with more than n lines, int
						-- colors = {}, -- table of hex strings
						-- termcolors = {} -- table of colour name strings
					},
				})
			end,
		},
		{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
		{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
	})
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				options = {
					styles = {
						comments = "italic",
						keywords = "italic",
					},
				},
			})
			vim.cmd("colorscheme nordfox")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				tabline = {
					lualine_a = { "buffers" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	})
	-- LSP, completion
	use({
		{
			"williamboman/mason.nvim",
			event = "VimEnter",
			config = function()
				require("mason").setup()
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup({
					ensure_installed = {
						-- 'gopls',
						"pyright",
						"sumneko_lua",
						-- 'terraformls',
						"tsserver",
					},
				})
			end,
			-- mason-lspconfig requires nvim-lspconfig, so we have to load it first
			after = "nvim-lspconfig",
		},
		{
			"neovim/nvim-lspconfig",
			event = "BufReadPre",
			config = function()
				require("plugins.lsp")
			end,
		},
		{
			"glepnir/lspsaga.nvim",
			branch = "main",
			config = function()
				require("lspsaga").init_lsp_saga({
					code_action_icon = "",
				})
			end,
			after = "nvim-lspconfig",
		},
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		config = function()
			require("plugins.null-ls")
		end,
	})
	use({
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			config = function()
				require("plugins.cmp")
			end,
			requires = {
				{
					"L3MON4D3/LuaSnip",
					event = "InsertEnter",
					config = function()
						require("plugins.luasnip")
					end,
					requires = {
						{
							"rafamadriz/friendly-snippets",
							event = "InsertEnter",
						},
					},
				},
			},
		},
		{
			"zbirenbaum/copilot-cmp",
			event = "VimEnter",
			requires = {
				{
					"zbirenbaum/copilot.lua",
					event = "VimEnter",
					config = function()
						vim.defer_fn(function()
							require("copilot").setup()
						end, 100)
					end,
				},
			},
		},
		{ "tzachar/cmp-tabnine", after = "nvim-cmp", run = "./install.sh" },
		{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
		{ "hrsh7th/cmp-path", after = "nvim-cmp" },
		{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
	})

	use({
		"github/copilot.vim",
		-- copilot.lua needs it for the authentication, at least for now
		cond = false,
		config = function()
			vim.g.copilot_filetypes = {
				markdown = true,
				yaml = true,
			}
		end,
	})
	-- utils
	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("colorizer").setup()
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.gitsigns")
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("indent_blankline").setup({
				show_end_of_line = true,
			})
		end,
	})
	use({
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	})
	use({
		{
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("plugins.telescope")
			end,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			after = "telescope.nvim",
			run = "make",
			config = function()
				---@diagnostic disable-next-line: different-requires
				require("telescope").load_extension("fzf")
			end,
		},
	})
	use({
		"windwp/nvim-autopairs",
		event = "InsertCharPre",
		-- load after nvim-cmp to ensure <CR> works correctly
		after = "nvim-cmp",
		config = function()
			require("nvim-autopairs").setup()
			-- integration with nvim-cmp
			---@diagnostic disable-next-line: different-requires
			require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	})
	use({
		"b3nj5m1n/kommentary",
		event = "BufRead",
	})
	use({
		"ntpeters/vim-better-whitespace",
		event = "BufRead",
	})
	use({
		"tpope/vim-surround",
		event = "BufRead",
		requires = {
			{
				"tpope/vim-repeat",
				event = "BufRead",
			},
		},
	})
	use({
		"tpope/vim-abolish",
		event = "BufRead",
	})
end)
