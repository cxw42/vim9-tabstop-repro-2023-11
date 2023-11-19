set nocompatible

set runtimepath-=/usr/local/share/vim/vimfiles,/usr/local/share/vim,/usr/local/share/vim/vimfiles/after
set runtimepath+=fzf

let g:REPRO=0

function! s:SetTabstop(which) abort
    let l:tabstop = 8
    let l:bufnr = str2nr(expand('<abuf>'))

    echom a:which . ': l:bufnr ' . l:bufnr . ', curr ' . bufnr()
    if l:bufnr != bufnr()
        echom "Skipping"
        return
    endif

    if g:REPRO == 1
        " This causes the cursor position to change
        call setbufvar(l:bufnr, '&tabstop', l:tabstop)
    elseif g:REPRO == 2
        " This does not cause the cursor position to change
        let &l:tabstop = l:tabstop
    endif
endfunction

augroup editorconfig
    autocmd!
    autocmd BufFilePost * call s:SetTabstop('BufFilePost')
augroup END

" vi: set ts=4 sts=4 sw=4 et ai:
