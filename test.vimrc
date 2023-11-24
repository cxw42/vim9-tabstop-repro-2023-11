set nocompatible

set runtimepath-=/usr/local/share/vim/vimfiles,/usr/local/share/vim,/usr/local/share/vim/vimfiles/after
set runtimepath+=fzf

let g:REPRO=0

function! s:SetTabstop(which) abort
    let l:tabstop = 8
    let l:abuf = str2nr(expand('<abuf>'))

    echom a:which . ': l:abuf ' . l:abuf . ', curr ' . bufnr()
        \ . '; repro ' . g:REPRO
        \ . '; bufname ' . bufname()
    if l:abuf != bufnr()
        echom "Skipping - abuf != bufnr"
        return
    endif

    " skip this event for terminal buffers, e.g., :FZF
    if bufname(l:abuf) =~ '^!\w*sh$'
        echom "Skipping - in a shell buffer"
        return
    endif

    if g:REPRO == 1
        " This causes the cursor position to change
        call setbufvar(l:abuf, '&tabstop', l:tabstop)
    elseif g:REPRO == 2
        " This does not cause the cursor position to change
        let &l:tabstop = l:tabstop
    elseif g:REPRO == 3
        eval 'setlocal tabstop=' . l:tabstop
    endif
endfunction

augroup editorconfig
    autocmd!
    autocmd BufFilePost * call s:SetTabstop('BufFilePost')
augroup END

" vi: set ts=4 sts=4 sw=4 et ai:
