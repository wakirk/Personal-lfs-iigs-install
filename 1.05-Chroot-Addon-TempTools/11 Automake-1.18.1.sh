#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Automake-1.18.1	https://www.linuxfromscratch.org/lfs/view/stable/chapter08/automake.html
	# Automake (1.18.1) - 1,614 KB:
	# Home page: https://www.gnu.org/software/automake/
	# Download: https://ftp.gnu.org/gnu/automake/automake-1.18.1.tar.xz
	# MD5 sum: cea31dbf1120f890cbf2a3032cfb9a68

	cd /sources
	rm -fR automake-1.18.1
	tar -vxsf automake-1.18.1.tar.xz
	cd automake-1.18.1

	./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.18.1
	make
#	make -j$(($(nproc)>4?$(nproc):8)) check
	make install

	cd /sources
	rm -fR automake-1.18.1

}

main

exit 0
