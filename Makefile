all: testrun

VIM = ~/src/vim/src/vim
testrun:
	$(VIM) --clean -u test.vimrc test.c

fzf-ec:
	$(VIM) --clean -u fzf-ec.vimrc test.c
