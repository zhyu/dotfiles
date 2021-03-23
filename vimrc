set encoding=utf-8
setglobal fileencoding=utf-8
scriptencoding utf-8

set nu
syntax on
set t_Co=256

set ignorecase
set smartcase

set timeout timeoutlen=500 ttimeoutlen=10
imap fd <Esc>
imap jk <Esc>

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
Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'zhyu/clap-tasks'
Plug 'vn-ki/coc-clap'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rizzatti/dash.vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

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

if has("autocmd")
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
  " force redraw when activate the new buffer
  autocmd BufEnter * :redraw!
endif

set list
set listchars=tab:\|\ ,eol:¬

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

" Append asyncrun status to section b
let g:asyncrun_status = "stopped"
function! CustomAirline(...)
  let w:airline_section_b = g:airline_section_b . ' T:%{g:asyncrun_status}'
endfunction
call airline#add_statusline_func('CustomAirline')
call airline#add_inactive_statusline_func('CustomAirline')

let g:go_auto_type_info = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" fix GoDoc bug caused by Arch's Golang bin conflicts with vim-go
" source ~/.vim/bundle/vim-go/ftplugin/go/godoc.vim

" for Dash
nmap <silent> <leader>da <Plug>DashSearch

" sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" Terraform
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" coc.nvim
"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc.nvim end

" Mappings using vim-clap:
" Manage coc extensions.
nnoremap <silent> <leader>ce  :<C-u>Clap coc_extensions<cr>
" Show coc commands.
nnoremap <silent> <leader>cc  :<C-u>Clap coc_commands<cr>
" Show vim commands.
nnoremap <silent> <leader>cm  :<C-u>Clap command<cr>
" Opened buffers
nnoremap <silent> <leader>b  :<C-u>Clap buffers<cr>
" Find files
nnoremap <silent> <leader>f  :<C-u>Clap files<cr>
" Grep
nnoremap <silent> <leader>g  :<C-u>Clap grep<cr>
" Grep the word under cursor
nnoremap <silent> <leader>gw  :<C-u>Clap grep ++query=<cword><cr>
" Grep the visual selection
vnoremap <silent> <leader>gs  :<C-u>Clap grep ++query=@visual<cr>
" Show all Clap options
nnoremap <silent> <leader>cl  :<C-u>Clap<cr>
" Filter lines in the current buffer.
nnoremap <silent> <leader>l  :<C-u>Clap blines<cr>
" Filter lines in loaded buffers.
nnoremap <silent> <leader>L  :<C-u>Clap lines<cr>
" Show tasks of asynctasks.vim
nnoremap <silent> <leader>t :<C-u>Clap tasks<cr>
