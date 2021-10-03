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

" Dash {{
if has('mac')
    nmap <silent> <leader>da <Plug>DashSearch
endif
" }} Dash

" telescope {{
nnoremap <silent> <leader>F <cmd>Telescope<cr>
nnoremap <silent> <leader>ff <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <silent> <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>fs <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <silent> <leader>fcm <cmd>Telescope commands<cr>
nnoremap <silent> <leader>fcc <cmd>Telescope coc commands<cr>
" }} telescope

" lazygit {{
nnoremap <silent> <leader>gg :LazyGit<CR>
" }}
