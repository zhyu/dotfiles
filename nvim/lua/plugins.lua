-- ensure packer.nvim is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd 'packadd packer.nvim'
end

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
                    enable = true
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
        'shaunsingh/nord.nvim',
        config = function() require('nord').set() end
    }
    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = false,
                    theme = 'nord'
                }
            }
        end
    }
    -- completion
    use {
        'neoclide/coc.nvim',
        branch = 'release'
    }
    -- language specific
    -- Elixir
    use 'elixir-editors/vim-elixir'
    -- Python
    use 'Glench/Vim-Jinja2-Syntax'
    -- Terraform TODO: highlight is using treesitter, replace this plugin with lsp?
    use 'hashivim/vim-terraform'
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
        config = function() require('telescope').load_extension('coc') end
    }
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }
    use 'windwp/nvim-ts-autotag'
    use 'p00f/nvim-ts-rainbow'
    use 'b3nj5m1n/kommentary'
    use 'ntpeters/vim-better-whitespace'
    use {
        'rizzatti/dash.vim',
        cond = function() return vim.fn.has('mac') == 1 end
    }
    use 'mattn/emmet-vim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-abolish'
    use 'skywind3000/asynctasks.vim'
    use 'skywind3000/asyncrun.vim'
    use 'kdheepak/lazygit.nvim'
end)
