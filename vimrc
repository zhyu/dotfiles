set encoding=utf-8
setglobal fileencoding=utf-8
scriptencoding utf-8

set nocompatible              " be iMproved

set nu
syntax on
set t_Co=256

set timeout timeoutlen=1000 ttimeoutlen=100
set <F13>=fd
imap <F13> <Esc>

" Automatic installation for vim-plug
" should be placed before plug#begin() call
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'bling/vim-airline'
Plug 'fatih/vim-go'
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rizzatti/dash.vim'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'plasticboy/vim-markdown'
Plug 'dyng/ctrlsf.vim'
Plug 'Lokaltog/vim-easymotion'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

colorscheme nord


set incsearch
set backspace=indent,eol,start
set et sta sw=2 ts=2 sts=2
set tags=tags;

" Space as Leader
let mapleader = "\<Space>"

" system clipboard
nmap <Leader>y "+y
nmap <Leader>d "+d
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" fold
set foldmethod=indent
set foldlevel=99
nnoremap <Leader><Leader> za
vnoremap <Leader><Leader> zf

if has("autocmd")
	autocmd FileType python setlocal et sta sw=4 ts=4 sts=4
	autocmd FileType html setlocal et sta sw=2 ts=2 sts=2
	autocmd QuickFixCmdPost * nested cwindow
	autocmd FileType javascript setlocal et sta sw=2 ts=2 sts=2
	autocmd Filetype javascript call JavaScriptFold()
	" js-beautify
	autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
	" for html
	autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
	" for css or scss
	autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
	" for go
	au FileType go setlocal et sta sw=8 ts=8 sts=8
  au FileType go nmap <Leader>s <Plug>(go-implements)
	au FileType go nmap <Leader>i <Plug>(go-info)
	au FileType go nmap <Leader>gd <Plug>(go-doc)
	au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
	au FileType go nmap <leader>r <Plug>(go-run)
	au FileType go nmap <leader>b <Plug>(go-build)
	au FileType go nmap <leader>t <Plug>(go-test)
	au FileType go nmap <leader>c <Plug>(go-coverage)
	au FileType go nmap <Leader>ds <Plug>(go-def-split)
	au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
	au FileType go nmap <Leader>dt <Plug>(go-def-tab)
	au FileType go nmap gd <Plug>(go-def)
  au FileType go nmap <Leader>e <Plug>(go-rename)
  " force redraw when activate the new buffer
  au BufEnter * :redraw!
endif

set list
set listchars=tab:\|\ ,eol:¬

" --- format visually selected JavaScript using esformatter --
vnoremap <silent> <leader>es :! esformatter<CR>

nnoremap <silent> <leader>f :PymodeLintAuto<cr>

"vim-airline config
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_detect_paste=1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

nnoremap <silent><F3> :TagbarToggle<cr>
imap <F3> <Esc>:TagbarToggle<cr>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
"let g:tagbar_indent = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_type_elixir = {'ctagstype': 'elixir', 'kinds': ['f:functions:0:0', 'c:callbacks:0:0', 'd:delegates:0:0', 'e:exceptions:0:0', 'i:implementations:0:0', 'a:macros:0:0', 'o:operators:0:0', 'm:modules:0:0', 'p:protocols:0:0', 'r:records:0:0'], 'sro': '.', 'kind2scope': {'m': 'modules'}, 'scope2kind': {'modules': 'm'}}

nnoremap <silent><F2> :NERDTreeToggle<cr>
imap <F2> <Esc>:NERDTreeToggle<cr>
let NERDTreeIgnore=['\.o$', '\.ko$', '\.symvers$', '\.order$', '\.mod.c$', '\.swp$', '\.bak$', '\~$', '\.pyc$', '\.pyo$']
"let NERDTreeSortOrder=['\/$', 'Makefile', 'makefile', '\.c$', '\.cc$', '\.cpp$', '\.h$', '*', '\~$']
let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=1
"let NERDTreeWinPos = 'right'
"let NERDTreeWinSize = 31

let g:UltiSnipsExpandTrigger='<c-j>'

let g:go_auto_type_info = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" fix GoDoc bug caused by Arch's Golang bin conflicts with vim-go
" source ~/.vim/bundle/vim-go/ftplugin/go/godoc.vim

let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_collect_identifiers_from_tags_files = 1

" fix the conflict between rope and ycm
let g:pymode_rope_completion = 0

" for Dash
nmap <silent> <leader>da <Plug>DashSearch

nmap <silent> <leader>gf <Plug>CtrlSFPrompt
nnoremap <silent><F4> :CtrlSFToggle<cr>
imap <F4> <Esc>:CtrlSFToggle<cr>

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
map <Leader>s <Plug>(easymotion-s)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1
" Match multibyte Japanese characters with alphabetical input
let g:EasyMotion_use_migemo = 1

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
