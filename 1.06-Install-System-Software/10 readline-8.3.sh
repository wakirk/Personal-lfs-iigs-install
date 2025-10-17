#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Readline (8.3) - 3,340 KB:
	# Home page: https://tiswww.case.edu/php/chet/readline/rltop.html
	# Download: https://ftp.gnu.org/gnu/readline/readline-8.3.tar.gz
	# MD5 sum: 25a73bfb2a3ad7146c5e9d4408d9f6cd
	echoR "System Software"

	echoL "Downloading Readline (8.3)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/readline/readline-8.3.tar.gz readline-8.3.tar.gz
	cp ../Packages/readline-8.3.tar.gz /sources

	echoL "Unpack Readline (8.3)..."
	sleep 2
	cd /sources
	rm -fR readline-8.3
	tar -vxsf readline-8.3.tar.gz
	cd readline-8.3

	echoL "Building Readline (8.3)..."
	sleep 2
	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install
	sed -i 's/-Wl,-rpath,[^ ]*//' support/shobj-conf
	./configure --prefix=/usr  \
		--disable-static       \
		--with-curses          \
		--docdir=/usr/share/doc/readline-8.3
	make SHLIB_LIBS="-lncursesw"

	echoL "Installing Readline (8.3)..."
	sleep 2
	make install
	install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.3

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR readline-8.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
