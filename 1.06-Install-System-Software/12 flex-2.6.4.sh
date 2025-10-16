#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Flex (2.6.4) - 1,386 KB:
	# Home page: https://github.com/westes/flex
	# Download: https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
	# MD5 sum: 2882e3179748cc9f9c23ec593d6adc8d
	echoR "System Software"

	echoL "Downloading Flex (2.6.4)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz flex-2.6.4.tar.gz
	cp ../Packages/flex-2.6.4.tar.gz /sources

	echoL "Unpack Flex (2.6.4)..."
	sleep 2
	cd /sources
	rm -fR flex-2.6.4
	tar -vxsf flex-2.6.4.tar.gz
	cd flex-2.6.4

	echoL "Building Flex (2.6.4)..."
	sleep 2
	./configure --prefix=/usr \
		--docdir=/usr/share/doc/flex-2.6.4 \
		--disable-static
	make

	echoL "Testing Flex (2.6.4)..."
	sleep 2
	make check

	echoL "Installing Flex (2.6.4)..."
	sleep 2
	make install
	ln -sv flex   /usr/bin/lex
	ln -sv flex.1 /usr/share/man/man1/lex.1

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR flex-2.6.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
