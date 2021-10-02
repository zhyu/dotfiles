require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'nord'
  }
}

require'nvim-treesitter.configs'.setup {
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

require('colorizer').setup()

require("indent_blankline").setup {
  show_end_of_line = true
}

require('gitsigns').setup()

require('nvim-autopairs').setup()

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
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
