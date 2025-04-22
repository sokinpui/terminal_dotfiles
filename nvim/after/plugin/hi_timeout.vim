augroup NoHLSearch
  au!
  autocmd CursorHold,CursorMoved * call <SID>NoHLAfter(4)
augroup END

function! s:NoHLAfter(n)
  if !exists('g:nohl_starttime')
    let g:nohl_starttime = localtime()
  else
    if v:hlsearch && (localtime() - g:nohl_starttime) >= a:n
      :nohlsearch
      redraw
      unlet g:nohl_starttime
    endif
  endif
endfunction
