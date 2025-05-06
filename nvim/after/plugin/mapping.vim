inoremap <C-k> <Esc>k
" nnoremap <C-q> <Cmd>q<cr>

nnoremap <Esc> <Cmd>nohlsearch<CR><Esc>

" delete whole word via Ctrl+backspace
inoremap <C-H> <C-w>
cnoremap <C-H> <C-w>
tnoremap <C-H> <C-w>

" copy and paste
if has("linux")
    nnoremap <leader>y "+y
    nnoremap <leader>d "+d
    nnoremap <leader>Y "+Y
    vnoremap Y "+ygv<esc>
    vnoremap X "+xgv<esc>
    vnoremap <C-c> "+ygv<esc>
    nnoremap <leader>P "+p']
    vnoremap <leader>P "+p']
    inoremap <C-v> <C-r><C-o>+
    cnoremap <C-v> <C-r><C-o>+
    nnoremap gy <Cmd>%y+<cr>
elseif has("macunix")
    " Allow copy paste in neovim
    let g:neovide_input_use_logo = 1
    " inoremap <D-v> <C-r><C-o>+
    nnoremap <leader>y "*y
    nnoremap <leader>d "*d
    nnoremap <leader>Y "*y$
    vnoremap Y "*y
    vnoremap <Space><Space> "*y
    vnoremap X "*xgv<esc>
    vnoremap <C-c> "*ygv<esc>
    nnoremap <leader>P "*p']
    vnoremap <leader>P "*p']
    " inoremap <C-v> <C-r><C-o>*
    " cnoremap <C-v> <C-r><C-o>*
    nnoremap gy <Cmd>%y*<cr>
endif

xnoremap <leader>p "_dP

" select the last pasted text
nnoremap gp '[v']

" increment and decrement of characters
"set nrformats+=alpha

"   Motion
" Vertical
noremap ( )
noremap ) (

"make {count}j/k become jumps
nnoremap <expr> j (v:count > 2 ? "m'" . v:count . "j" : "j")
nnoremap <expr> k (v:count > 2 ? "m'" . v:count . "k" : "k")

nnoremap Q @q

nnoremap n <Cmd>set hlsearch<Cr>n
nnoremap N <Cmd>set hlsearch<Cr>N
nnoremap * <Cmd>set hlsearch<Cr>*
nnoremap # <Cmd>set hlsearch<Cr>#
vnoremap * y<Cmd>set hlsearch<Cr>/<c-r>0<cr>
vnoremap # y<Cmd>set hlsearch<Cr>?<c-r>0<cr>
nnoremap g* <Cmd>set hlsearch<Cr>g*
nnoremap g# <Cmd>set hlsearch<Cr>g#


" exact search
nnoremap <leader>/ /\<\><Left><Left>

" indention formation
nnoremap =<leader> gg=G`'

" should be leverge the built in . repeat
vnoremap < <gv
vnoremap > >gv

"   Command alias
cnoreabbrev <expr> W getcmdtype() == ':' && getcmdline() =~# '^W' ? 'w' : 'W'
cnoreabbrev <expr> WQ getcmdtype() == ':' && getcmdline() =~# '^WQ' ? 'wqa' : 'WQ'
cnoreabbrev <expr> Wq getcmdtype() == ':' && getcmdline() =~# '^Wq' ? 'wqa' : 'Wq'
cnoreabbrev <expr> wQ getcmdtype() == ':' && getcmdline() =~# '^wQ' ? 'wqa' : 'wQ'
cnoreabbrev <expr> wq getcmdtype() == ':' && getcmdline() =~# '^wq' ? 'wqa' : 'wq'
cnoreabbrev <expr> Q getcmdtype() == ':' && getcmdline() =~# '^Q' ? 'q' : 'Q'
cnoreabbrev <expr> wqa getcmdtype() == ':' && getcmdline() =~# '^wqa' ? 'wa \| q' : 'wqa'
cnoreabbrev <expr> Wqa getcmdtype() == ':' && getcmdline() =~# '^wqa' ? 'wa \| q' : 'wqa'
cnoreabbrev <expr> WQa getcmdtype() == ':' && getcmdline() =~# '^wqa' ? 'wa \| q' : 'wqa'
cnoreabbrev <expr> wQa getcmdtype() == ':' && getcmdline() =~# '^wqa' ? 'wa \| q' : 'wqa'

"nnoremap <leader><leader> <Cmd>source<Cr>

" " change tmux pane focus
" nnoremap <A-h> <Cmd>silent !tmux select-pane -L<cr>
" nnoremap <A-j> <Cmd>silent !tmux select-pane -D<cr>
" nnoremap <A-k> <Cmd>silent !tmux select-pane -U<cr>
" nnoremap <A-l> <Cmd>silent !tmux select-pane -R<cr>

" if in tmux then split pane, else use toggleterm
if exists('$TMUX')
    nnoremap <c-t> <Cmd>silent !tmux splitw -v -l 20<cr>
else
    nnoremap <c-t> <Cmd>ToggleTerm<cr>
endif

