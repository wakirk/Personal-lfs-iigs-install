#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Vim (9.1.1629) - 18,317 KB:
	# Home page: https://www.vim.org
	# Download: https://github.com/vim/vim/archive/v9.1.1629/vim-9.1.1629.tar.gz
	# MD5 sum: 4f856c3233c1c4570bc17572e4f9e8e4
	echoR "System Software"

	echoL "Downloading Vim (9.1.1629)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/vim/vim/archive/v9.1.1629/vim-9.1.1629.tar.gz vim-9.1.1629.tar.gz
	cp ../Packages/vim-9.1.1629.tar.gz /sources

	echoL "Unpack Vim (9.1.1629)..."
	sleep 2
	cd /sources
	rm -fR vim-9.1.1629
	tar -vxsf vim-9.1.1629.tar.gz
	cd vim-9.1.1629

	echoL "Building Vim (9.1.1629)..."
	sleep 2
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	./configure --prefix=/usr
	make

	echoL "Testing Vim (9.1.1629)..."
	sleep 2
	chown -R tester .
	sed '/test_plugin_glvs/d' -i src/testdir/Make_all.mak
#	su tester -c "TERM=xterm-256color LANG=en_US.UTF-8 make -j1 test" # &> vim-test.log

	echoL "Installing Vim (9.1.1629)..."
	sleep 2
	make install
	ln -fsv vim /usr/bin/vi
	for L in  /usr/share/man/{,*/}man1/vim.1; do
		ln -fsv vim.1 $(dirname $L)/vi.1
	done
	ln -fsv ../vim/vim91/doc /usr/share/doc/vim-9.1.1629
	cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif
set spelllang=en
set spell

" End /etc/vimrc
EOF

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR vim-9.1.1629
	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
