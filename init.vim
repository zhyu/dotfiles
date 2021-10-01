" plug.vim {{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin(stdpath('data') . '/plugged')
" lua lib that other plugins depend on
Plug 'nvim-lua/plenary.nvim'
" UI
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'shaunsingh/nord.nvim'
Plug 'hoob3rt/lualine.nvim'
" complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" language specific
" - Elixir
Plug 'elixir-editors/vim-elixir'
" - Python
Plug 'Glench/Vim-Jinja2-Syntax'
" - Javascript & Typescript
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
" - Terraform
Plug 'hashivim/vim-terraform'
" - CSS
Plug 'ap/vim-css-color'
" - Markdown
Plug 'plasticboy/vim-markdown'
" utils
Plug 'lewis6991/gitsigns.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'zhyu/clap-tasks'
Plug 'vn-ki/coc-clap'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'p00f/nvim-ts-rainbow'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rizzatti/dash.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'kdheepak/lazygit.nvim'

call plug#end()
" }} plug.vim

" basic {{
set encoding=utf-8
setglobal fileencoding=utf-8
scriptencoding utf-8

set termguicolors
colorscheme nord

set number
set hidden
set list listchars=tab:\|\ ,eol:¬
set cmdheight=2
set signcolumn=number

set nobackup
set nowritebackup

set ignorecase
set smartcase
set incsearch

set backspace=indent,eol,start
set et sta sw=2 ts=2 sts=2

set foldmethod=indent
set foldlevel=99

set timeout timeoutlen=500 ttimeoutlen=10
"
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0

" Space as Leader
let mapleader = "\<Space>"
" }} basic

" autocmd {{
augroup common
  autocmd!
  " quickfix
  autocmd QuickFixCmdPost * nested cwindow
  " Python
  autocmd FileType python setlocal et sta sw=4 ts=4 sts=4
  " Javascript
  autocmd FileType javascript,javascriptreact setlocal et sta sw=4 ts=4 sts=4
  " HTML
  autocmd FileType html setlocal et sta sw=4 ts=4 sts=4
  " Golang
  autocmd FileType go setlocal noet sw=4 ts=4 sts=4
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" }} autocmd

" command {{
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')
" }} command

" mappings {{
imap fd <Esc>
imap jk <Esc>

" system clipboard
nmap <Leader>y "+y
nmap <Leader>d "+d
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" }} mappings

" functions {{
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" }} functions

" Dash {{
nmap <silent> <leader>da <Plug>DashSearch
" }} Dash

" Terraform {{
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1
" }} Terraform

" coc.nvim {{
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" }} coc.nvim

" vim-clap {{
nnoremap <silent> <leader>ce  :<C-u>Clap coc_extensions<cr>
nnoremap <silent> <leader>cc  :<C-u>Clap coc_commands<cr>
nnoremap <silent> <leader>cm  :<C-u>Clap command<cr>
nnoremap <silent> <leader>b  :<C-u>Clap buffers<cr>
nnoremap <silent> <leader>f  :<C-u>Clap files<cr>
nnoremap <silent> <leader>g  :<C-u>Clap grep<cr>
nnoremap <silent> <leader>gw  :<C-u>Clap grep ++query=<cword><cr>
vnoremap <silent> <leader>gs  :<C-u>Clap grep ++query=@visual<cr>
nnoremap <silent> <leader>cl  :<C-u>Clap<cr>
nnoremap <silent> <leader>l  :<C-u>Clap blines<cr>
nnoremap <silent> <leader>L  :<C-u>Clap lines<cr>
nnoremap <silent> <leader>t :<C-u>Clap tasks<cr>
" }} vim-clap

" lazygit {{
nnoremap <silent> <leader>gg :LazyGit<CR>
" }}

" lua {{
lua << EOF
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
require('nvim-autopairs').setup{}
require("indent_blankline").setup {
  show_end_of_line = true
}
require('gitsigns').setup()
EOF
" }} lua
