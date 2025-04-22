"    Appearance
"set background=dark

"syntax on

set termguicolors

" "  statusline setting
" function Gitbranch()
"     return "  " . trim(system("git -C " . expand("%:h") . " branch --show-current 2>/dev/null")) . " "
" endfunction
"
" augroup Gitget
"     autocmd!
"     autocmd BufEnter * let b:git_branch = Gitbranch()
" augroup END
"
" let g:currentmode={
"       \ 'n'  : 'n',
"       \ 'v'  : 'v',
"       \ 'V'  : 'vl',
"       \ '' : 'vb',
"       \ 'i'  : 'i',
"       \ 'R'  : 'r',
"       \ 'Rv' : 'rv',
"       \ 'c'  : 'c',
"       \ 't'  : 'f',
"       \}
"
" hi GitBranchColor gui=bold guifg=#282c34 guibg=#98c379
" hi StatusLineText guifg=#abb2bf guibg=#3e4452
"
" hi NormalColor gui=bold guifg=#282c34 guibg=#e06c75
" hi InsertColor gui=bold guifg=#282c34 guibg=#e5c07b
" hi lualine_a_normal gui=bold guifg=#282c34 guibg=#98c379
" hi lualine_a_insert gui=bold guifg=#282c34 guibg=#61afef
"
" set statusline+=%#NormalColor#%{(g:currentmode[mode()]=='n')?'b:git_branch':''}
" set statusline+=%#InsertColor#%{(g:currentmode[mode()]=='i')?'b:git_branch':''}
" set statusline+=%#ReplaceColor#%{(g:currentmode[mode()]=='r')?'b:git_branch':''}
" set statusline+=%#NormalColor#%{(g:currentmode[mode()]=='c')?'b:git_branch':''}
" " set statusline+=%#GitBranchColor#%{b:git_branch}%#StatusLineText#\ %<%F\ %h%m%r%=%-5.(%l-%c%)\ %p%%
" set statusline+=%#StatusLineText#\ %<%F\ %h%m%r%=%-5.(%l-%c%)\ %p%%
set laststatus=2

hi Cursor2 guibg=cyan

" I like block blink cursor
set guicursor=i:block,r-cr-o:hor50,a:blinkon100,n-v-c-sm:block-Cursor2/lCursor2


" cursor shape
"let &t_SR = "\e[4 q" "SR = REPLACE mode
"let &t_EI = "\e[2 q" "EI = NORMAL mode (ELSE)
"let &t_SI = "\e[6 q" "SI = INSERT mode

"    Highlight
"  Search
set incsearch
set hlsearch
set ignorecase
set smartcase
augroup AutoHighlighting
    au!
    autocmd insertenter * set nohlsearch
    autocmd textchanged * set nohlsearch
    autocmd CmdlineEnter /,\? set hlsearch
augroup END

highlight Visual ctermbg=242 guibg=#3e6452
" highlight MatchParen ctermbg=6 gui=bold guifg=yellowgreen guibg=#282c34
highlight MatchParen ctermbg=6 gui=bold guifg=tomato guibg=#282c34
highlight MatchWord ctermbg=6 gui=italic guifg=yellowgreen guibg=#282c34
highlight Search ctermfg=0 ctermbg=11 gui=bold,italic guifg=#080808 guibg=#61afef
highlight IncSearch cterm=reverse gui=bold,italic guifg=#31353f guibg=#e5c07b
highlight CurSearch gui=bold,italic guifg=#080808 guibg=#d19a66
highlight Comment gui=bold,italic guifg=#808080
highlight @comment gui=bold,italic guifg=#808080

set scrolloff=8
set signcolumn=yes
set listchars=space:⋅
set pumheight=30

set nocursorline
" auto hide and show cursorline when leave windows
"augroup CursorLine
"    au!
"    au VimEnter * setlocal cursorline
"    au WinEnter * setlocal cursorline
"    au BufWinEnter * setlocal cursorline
"    au WinLeave * setlocal nocursorline
"augroup END

" remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * if expand('%') != '' | mkview | endif
  autocmd BufWinEnter * silent! loadview
augroup END
