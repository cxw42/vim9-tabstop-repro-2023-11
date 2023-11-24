set nocompatible

set runtimepath-=/usr/local/share/vim/vimfiles,/usr/local/share/vim,/usr/local/share/vim/vimfiles/after
set runtimepath+=fzf,~/proj/ec/editorconfig-vim

autocmd FileType c EditorConfigReload
