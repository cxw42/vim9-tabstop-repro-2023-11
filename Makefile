all: testrun

VIM = ~/src/vim/src/vim
testrun:
	$(VIM) --clean -u test.vimrc test.c
