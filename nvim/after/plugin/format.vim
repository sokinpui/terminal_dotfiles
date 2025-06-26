"    Indention
set softtabstop=-1
set tabstop=8
set expandtab
set shiftwidth=4
set autoindent
set smartindent

"set iskeyword+=\-,\.,\*

"    Text width and line wrapping
augroup ftTextwidthWrap
    au!
    au filetype zsh,sh setlocal textwidth=0 wrap formatoptions=tcq linebreak shiftwidth=2
    au filetype vim,lua setlocal textwidth=0 wrap formatoptions=tcq linebreak
    au filetype yaml,conf setlocal textwidth=0 wrap formatoptions=tcq linebreak
    au filetype c,python setlocal textwidth=0 wrap formatoptions=tcq linebreak
    au filetype text,markdown setlocal textwidth=0 wrap formatoptions=tcq2n linebreak iskeyword+=\-
    au filetype java setlocal formatoptions-=ro
    au filetype typescript setlocal formatoptions-=ro
    au filetype typescriptreact setlocal formatoptions-=ro
    "au filetype text,markdown setlocal formatoptions=tcaw2n textwidth=80 linebreak
augroup END


" augroup ttt
"     au!
"     " kill empty buffer after TermClose
"     au TermClose * if &buftype == 'terminal' && line('$') == 1 && getline(1) == '' | q! | endif
" augroup END
