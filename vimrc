set encoding=utf-8
setglobal fileencoding=utf-8
scriptencoding utf-8

set nu
syntax on
set t_Co=256

set timeout timeoutlen=1000 ttimeoutlen=100
imap fd <Esc>

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

" UI
Plug 'arcticicestudio/nord-vim'
Plug 'bling/vim-airline'
" complete
Plug 'ycm-core/YouCompleteMe'
" language specific
" - Python
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'psf/black'
Plug 'Glench/Vim-Jinja2-Syntax'
" - Javascript
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'maksimr/vim-jsbeautify'
" - CSS
Plug 'ap/vim-css-color'
" - Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" - Markdown
Plug 'plasticboy/vim-markdown'
" utils
Plug 'tpope/vim-fugitive'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rizzatti/dash.vim'
Plug 'mattn/emmet-vim'
Plug 'Lokaltog/vim-easymotion'
Plug '~/.fzf'
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
  " quickfix
  autocmd QuickFixCmdPost * nested cwindow
  " Python
  autocmd FileType python setlocal et sta sw=4 ts=4 sts=4
  autocmd BufWritePre *.py execute ':Black'
  " Javascript
  autocmd FileType javascript setlocal et sta sw=2 ts=2 sts=2
  autocmd Filetype javascript call JavaScriptFold()
  autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  " HTML
  autocmd FileType html setlocal et sta sw=2 ts=2 sts=2
  autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  " CSS
  autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
  " Golang
  autocmd FileType go setlocal et sta sw=8 ts=8 sts=8
  autocmd FileType go nmap <Leader>s <Plug>(go-implements)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>c <Plug>(go-coverage)
  autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
  autocmd FileType go nmap gd <Plug>(go-def)
  autocmd FileType go nmap <Leader>e <Plug>(go-rename)
  " force redraw when activate the new buffer
  autocmd BufEnter * :redraw!
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

let g:go_auto_type_info = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" fix GoDoc bug caused by Arch's Golang bin conflicts with vim-go
" source ~/.vim/bundle/vim-go/ftplugin/go/godoc.vim

let g:ycm_server_python_interpreter = $HOME . '/.pyenv/versions/neovim/bin/python'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_collect_identifiers_from_tags_files = 1

"fix the conflict between rope and ycm
let g:pymode_rope_completion = 0
let g:pymode_options_max_line_length = 88

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

" fzf
" Files: command with preview, need to install https://github.com/sharkdp/bat
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
