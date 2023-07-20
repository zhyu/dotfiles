-- ensure packer.nvim is installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

-- use plugins
local function plugins(use)
	-- packer itself
	use("wbthomason/packer.nvim")
	-- Load only when require
	use({ "nvim-lua/plenary.nvim", module = "plenary" })
	use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })
	-- UI
	use({
		{
			"nvim-treesitter/nvim-treesitter",
			-- Similar to the mason + lspconfig case, treesitter could be required by
			-- telescope for previewing.
			-- Open a file from CLI:
			--   BufReadPre (load treesitter) -> VimEnter
			-- Start nvim and open files later:
			--   VimEnter (load treesitter and telescope) -> open files -> BufReadPre
			event = { "BufReadPre", "VimEnter" },
			run = ":TSUpdate",
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
		},
		{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
		{
			"https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
			after = "nvim-treesitter",
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
			-- mason updates the PATH for installed LSP servers, so we need to load it
			-- on BufReadPre, which is the time we load lspconfig as well, to ensure LSP
			-- servers could be started when we open a file from CLI.
			-- We also need to load mason on VimEnter to setup user commands to manage
			-- LSP servers without opening a file.
			-- Open a file from CLI:
			--   BufReadPre (load mason and lspconfig) -> VimEnter
			-- Start nvim and open files later:
			--   VimEnter (load mason and lspconfig) -> open files -> BufReadPre
			event = { "BufReadPre", "VimEnter" },
			config = function()
				require("mason").setup()
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("plugins.mason-lspconfig")
			end,
			-- mason-lspconfig requires nvim-lspconfig, so we have to load it first
			after = { "nvim-lspconfig", "mason.nvim" },
		},
		{
			"neovim/nvim-lspconfig",
			event = "BufReadPre",
			config = function()
				require("plugins.lsp")
			end,
			requires = {
				-- cmp-nvim-lsp is needed to update lsp client capabilities
				{ "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
			},
		},
		{
			"glepnir/lspsaga.nvim",
			branch = "main",
			config = function()
				require("lspsaga").setup({
					ui = {
						code_action_icon = "",
					},
					-- jdtls is pretty slow
					request_timeout = 5000,
				})
			end,
			after = "nvim-lspconfig",
		},
		{
			"mfussenegger/nvim-jdtls",
			-- We need to run the setup every time when a java file is opened
			-- to make sure the jdtls server is attached.
			-- However, load the plugin with ft = "java" will only load it once,
			-- so the setup is called in autocmds.lua with FileType event.
			-- Declaring the module is needed to ensure it can be loaded correctly.
			module = "jdtls",
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
			after = "nvim-cmp",
			config = function()
				require("copilot_cmp").setup()
			end,
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
	})
	-- utils
	use({
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()
		end,
	})
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
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("Comment").setup()
		end,
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
end

local packer = require("packer")

packer.startup(plugins)
