setlocal textwidth=0 wrap formatoptions=tc2n linebreak
setlocal foldmethod=expr

"set concealcursor=""
nnoremap <buffer> <expr> <leader><C-l> &conceallevel == 0 ? "<Cmd>set conceallevel=2<Cr>" : "<Cmd>set conceallevel=0<cr>"

noremap <buffer> j gj
noremap <buffer> k gk
" noremap <buffer> $ g$
" noremap <buffer> ^ g^
" noremap <buffer> 0 g0

"nnoremap <buffer> dd g0vg$D
"nnoremap <buffer> D g0vg$D

nnoremap <buffer> G Gg_

" nnoremap <buffer> I g^i

" nnoremap <buffer> A g$a
"nnoremap <buffer> A <Cmd>call markdown#IsBlank()<cr>

" nnoremap <buffer> gV g0vg$
"call markdown_latex#MDSettings()

" number list
nnoremap <buffer> gll :LazyList<cr>
vnoremap <buffer> gll :LazyList<cr>

" unorder list
nnoremap <buffer> gld :LazyList - <cr>
vnoremap <buffer> gld :LazyList - <cr>

" coachshea/vim-textobj-markdown
"" codeblock
onoremap <buffer> ic <plug>(textobj-markdown-Bchunk-i)
onoremap <buffer> ac <plug>(textobj-markdown-Bchunk-a)
vnoremap <buffer> ic <plug>(textobj-markdown-Bchunk-i)
vnoremap <buffer> ac <plug>(textobj-markdown-Bchunk-a)

"AckslD/nvim-FeMaco.lua",
nnoremap <buffer> <leader>c <Cmd>FeMaco<cr>

highlight! Conceal gui=bold cterm=bold

cnoreabbrev <buffer> toc Toc

command -buffer UpdateBlog :r! echo "> update at `date`"
