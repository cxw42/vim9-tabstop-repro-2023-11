set nocompatible

set runtimepath-=/usr/local/share/vim/vimfiles,/usr/local/share/vim,/usr/local/share/vim/vimfiles/after
set runtimepath+=fzf

let g:REPRO=0

function! s:PrintPosInWindowForBuf(bufnr) abort
    try
        let l:winnr = win_findbuf(a:bufnr)[0]
        call win_execute(l:winnr, 'let s:pos = getcurpos()')
        echom 'Current position in ' . a:bufnr . ' is ' . string(s:pos)
    catch
        echom 'No window for buffer ' . a:bufnr
    endtry
endfunction

function! s:ApplyConfig(bufnr, config) abort
    call s:PrintPosInWindowForBuf(a:bufnr)
    call s:PrintPosInWindowForBuf(1)
    let l:tabstop = str2nr(a:config["tab_width"])
    if g:REPRO == 1
        call setbufvar(a:bufnr, '&tabstop', l:tabstop)
    elseif g:REPRO == 2
        let &l:tabstop = l:tabstop
    endif

    if g:REPRO
        call s:PrintPosInWindowForBuf(a:bufnr)
        call s:PrintPosInWindowForBuf(1)
    endif
endfunction

function! s:UseConfigFiles_VimCore(bufnr, target)
    call s:ApplyConfig(a:bufnr, { "tab_width": 8 })
endfunction

function! s:UseConfigFiles() abort
    let l:bufnr = str2nr(expand('<abuf>'))
    let l:buffer_name = expand('<afile>:p')
    let l:buffer_path = expand('<afile>:p:h')
    echom 'Processing buffer ' . string(l:bufnr) . ', name ' . l:buffer_name
        \ . ', path ' . l:buffer_path
        \ . ', buftype ' . getbufvar(l:bufnr, '&buftype')
    call s:UseConfigFiles_VimCore(l:bufnr, l:buffer_name)
endfunction

augroup editorconfig
    autocmd!
    autocmd BufNewFile,BufReadPost,BufFilePost * call s:UseConfigFiles()
    autocmd VimEnter,BufNew * call s:UseConfigFiles()
augroup END

" vi: set ts=4 sts=4 sw=4 et ai:
