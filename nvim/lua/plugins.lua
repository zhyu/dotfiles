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
            local nightfox = require('nightfox')
            nightfox.setup {
                fox = "nordfox",
                styles = {
                    comments = "italic",
                    keywords = "italic",
                }
            }
            nightfox.load()
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'nightfox'
                },
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
    -- completion
    use {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vimscript/plugins/coc.vim')
        end
    }
    use 'github/copilot.vim'
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
            local action_set = require('telescope.actions.set')
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
                },
                -- No Folds Found for files opened with telescope when using treesitter based folding
                -- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-886123429
                pickers = {
                    find_files = {
                        attach_mappings = function(prompt_bufnr)
                            action_set.select:enhance({
                                post = function()
                                    -- note: this works well for newly opening a file, however,
                                    -- it also resets the folds every time the buffer is focused
                                    vim.cmd(":normal! zx")
                                end
                            })
                            return true
                        end
                    },
                }
            }

            vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vimscript/plugins/telescope.vim')
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
        -- skip mapping <cr> to avoid conflict with coc
        config = function() require('nvim-autopairs').setup({ map_cr = false }) end
    }
    use 'windwp/nvim-ts-autotag'
    use 'p00f/nvim-ts-rainbow'
    use 'b3nj5m1n/kommentary'
    use {
        'monaqa/dial.nvim',
        config = function ()
            local dial = require('dial')
            table.insert(dial.config.searchlist.normal, "date#[%H:%M:%S]")
            table.insert(dial.config.searchlist.visual, "date#[%H:%M:%S]")

            vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vimscript/plugins/dial.vim')
        end
    }
    use 'ntpeters/vim-better-whitespace'
    use {
        'rizzatti/dash.vim',
        cond = function() return vim.fn.has('mac') == 1 end,
        config = function()
            vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vimscript/plugins/dash.vim')
        end
    }
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-abolish'
    -- use 'skywind3000/asynctasks.vim'
    -- use 'skywind3000/asyncrun.vim'
end)
