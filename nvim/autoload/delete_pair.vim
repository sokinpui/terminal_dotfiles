function delete_pair#BetterBS()
    let g:couples = ['`#`', '(#)', '[#]', '{#}', '<#>', '"#"', "'#'", "$#$", "*#*"] 
    for l:couple in g:couples
        if ! (l:couple =~ '#')
            continue
        endif
        let l:regex = substitute(escape(l:couple, '/\^$*.[~'), '#', '\\%#', '')
        if search(l:regex, 'n')
            let l:out = repeat("\<BS>", len(matchstr(l:couple, '^.\{-}\ze#')))
            let l:out .= repeat("\<DEL>", len(matchstr(l:couple, '#\zs.\{-}$')))
            return l:out
        endif
    endfor
    return "\<BS>"
endfunction
