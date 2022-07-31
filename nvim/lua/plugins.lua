-- ensure packer.nvim is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd 'packadd packer.nvim'
end

local enableCoc = false

-- use plugins
require('packer').startup(function(use)
    -- packer itself
    use 'wbthomason/packer.nvim'
    -- UI
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
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
                    "yaml"
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
                }
            }
        end
    }
    use {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup {
                options = {
                    styles = {
                        comments = "italic",
                        keywords = "italic",
                    }
                }
            }
            vim.cmd('colorscheme nordfox')
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup {
                tabline = {
                    lualine_a = { "buffers" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                }
            }
        end
    }
    -- LSP, completion
    use {
        'neoclide/coc.nvim',
        branch = 'release',
        cond = enableCoc,
        config = function()
            vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vimscript/plugins/coc.vim')
        end
    }

    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    }
    use {
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            config = function()
                local cmp = require('cmp')
                cmp.setup({
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body)
                        end
                    },
                    sources = {
                        { name = 'copilot' },
                        { name = 'path' },
                        { name = 'buffer' },
                    },
                    formatting = {
                        fields = {'menu', 'abbr', 'kind'},
                        format = function(entry, item)
                            local menu_icon = {
                                nvim_lsp = 'λ',
                                luasnip = '⋗',
                                buffer = 'Ω',
                                path = '🖫',
                                copilot = '',
                            }

                            item.menu = menu_icon[entry.source.name]
                            return item
                        end,
                    },
                    mapping = {
                        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
                        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({select = true}),
                        ['<Tab>'] = cmp.mapping(function(fallback)
                            local col = vim.fn.col('.') - 1

                            if cmp.visible() then
                                cmp.select_next_item(select_opts)
                            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                                fallback()
                            else
                                cmp.complete()
                            end
                        end, {'i', 's'}),

                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item(select_opts)
                            else
                                fallback()
                            end
                        end, {'i', 's'}),
                    }
                })
            end,
            requires = {
                {
                    'L3MON4D3/LuaSnip',
                    event = 'InsertEnter',
                    requires = {
                        {
                            'rafamadriz/friendly-snippets',
                            event = 'CursorHold',
                        }
                    }
                }
            },
        },
        {
            "zbirenbaum/copilot-cmp",
            requires = {
                {
                    "zbirenbaum/copilot.lua",
                    event = "VimEnter",
                    config = function()
                        vim.defer_fn(function()
                            require("copilot").setup()
                        end, 100)
                    end,
                }
            }
        },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    }

    use { 'github/copilot.vim',
        cond = false,
        config = function()
            vim.g.copilot_filetypes = {
                markdown = true,
                yaml = true,
            }
        end
    }
    -- language specific
    -- Elixir
    use {
        'elixir-editors/vim-elixir',
        ft = {'elixir'}
    }
    -- Terraform TODO: highlight is using treesitter, replace this plugin with lsp?
    use {
        'hashivim/vim-terraform',
        ft = {'hcl', 'terraform'},
        config = function()
            vim.g.terraform_align=1
            vim.g.terraform_fold_sections=1
            vim.g.terraform_fmt_on_save=1
        end
    }
    -- utils
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                show_end_of_line = true
            }
        end
    }
    use 'ggandor/lightspeed.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            local actions = require('telescope.actions')
            require('telescope').setup {
                defaults = {
                    layout_strategy = 'vertical',
                    layout_config = {
                        vertical = { width = 0.66 }
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        }
                    }
                }
            }
        end
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        config = function() require('telescope').load_extension('fzf') end
    }
    use {
        'fannheyward/telescope-coc.nvim',
        cond = enableCoc,
        config = function() require('telescope').load_extension('coc') end
    }
    use {
        'windwp/nvim-autopairs',
        -- skip mapping <cr> to avoid conflict with coc
        config = function() require('nvim-autopairs').setup({ map_cr = false }) end
    }
    use 'windwp/nvim-ts-autotag'
    use 'p00f/nvim-ts-rainbow'
    use 'b3nj5m1n/kommentary'
    use 'ntpeters/vim-better-whitespace'
    use {
        'rizzatti/dash.vim',
        cond = function() return vim.fn.has('mac') == 1 end,
    }
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-abolish'
    -- use 'skywind3000/asynctasks.vim'
    -- use 'skywind3000/asyncrun.vim'
end)
