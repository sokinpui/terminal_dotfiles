if exists("g:loaded_delete_pair")
    finish
endif
let g:loaded_delete_pair = 1

inoremap <silent> <BS> <C-r>=delete_pair#BetterBS()<CR>

