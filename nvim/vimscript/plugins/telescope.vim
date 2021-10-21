nnoremap <silent> <leader>F <cmd>Telescope<cr>
nnoremap <silent> <leader>ff <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <silent> <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>fs <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <silent> <leader>fcm <cmd>Telescope commands<cr>
nnoremap <silent> <leader>fcc <cmd>Telescope coc commands<cr>

" GoTo code navigation.
nmap <silent> gd <cmd>Telescope coc definitions<cr>
nmap <silent> gy <cmd>Telescope coc type_definitions<cr>
nmap <silent> gi <cmd>Telescope coc implementations<cr>
nmap <silent> gr <cmd>Telescope coc references<cr>
