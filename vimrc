set encoding=utf-8
setglobal fileencoding=utf-8
scriptencoding utf-8

set nocompatible              " be iMproved

set nu
syntax on
color molokai
set t_Co=256

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'JavaScript-Indent'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'marijnh/tern_for_vim'
Plugin 'othree/tern_for_vim_coffee'		" need for tern-coffee
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Raimondi/delimitMate'
Plugin 'Yggdroot/indentLine'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'rizzatti/dash.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'lukaszkorecki/CoffeeTags'
Plugin 'ap/vim-css-color'
Plugin 'wavded/vim-stylus'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'briancollins/vim-jst'
Plugin 'mattn/emmet-vim'
Plugin 'klen/python-mode'
Plugin 'dag/vim2hs'
Plugin 'eagletmt/neco-ghc'
Plugin 'plasticboy/vim-markdown'
Plugin 'wakatime/vim-wakatime'
Plugin 'elixir-lang/vim-elixir'
Plugin 'carlosgaldino/elixir-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'Lokaltog/vim-easymotion'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" if has("autocmd") && exists("+omnifunc")
" 	autocmd Filetype *
"     \	if &omnifunc == "" |
"     \	 setlocal omnifunc=syntaxcomplete#Complete |
"     \	endif
" endif

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
	autocmd FileType haskell setlocal et sta sw=4 ts=4 sts=4
	autocmd FileType python setlocal et sta sw=4 ts=4 sts=4
	autocmd FileType jinja setlocal et sta sw=2 ts=2 sts=2
	autocmd FileType html setlocal et sta sw=2 ts=2 sts=2
	autocmd FileType coffee setlocal et sta sw=2 ts=2 sts=2
	autocmd FileType coffee nmap <Leader>w :CoffeeWatch vert<CR>
	autocmd BufWritePost *.coffee silent make!
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

let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_semantic_triggers =  {
      \   'coffee' : ['.'],
      \   'haskell' : ['.'],
      \ }

" fix the conflict between rope and ycm
let g:pymode_rope_completion = 0

" for Dash
nmap <silent> <leader>da <Plug>DashSearch

let g:CoffeeAutoTagIncludeVars=1

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
nnoremap <leader>. :CtrlPTag<cr>

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
