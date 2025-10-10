#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Autoconf-2.72	https://www.linuxfromscratch.org/lfs/view/stable/chapter08/autoconf.html
	# Autoconf (2.72) - 1,360 KB:
	# Home page: https://www.gnu.org/software/autoconf/
	# Download: https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz
	# MD5 sum: 1be79f7106ab6767f18391c5e22be701

	cd /sources
	rm -fR autoconf-2.72
	tar -vxsf autoconf-2.72.tar.xz
	cd autoconf-2.72

	./configure --prefix=/usr
	make
#	make check
	make install
	
	cd /sources
	rm -fR autoconf-2.72
}

main

exit 0
