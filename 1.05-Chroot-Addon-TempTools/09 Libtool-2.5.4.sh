#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Libtool-2.5.4	https://www.linuxfromscratch.org/lfs/view/stable/chapter08/libtool.html
	# Libtool (2.5.4) - 1,033 KB:
	# Home page: https://www.gnu.org/software/libtool/
	# Download: https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz
	# MD5 sum: 22e0a29df8af5fdde276ea3a7d351d30

	cd /sources
	rm -fR libtool-2.5.4
	tar -vxsf libtool-2.5.4.tar.xz
	cd libtool-2.5.4

	./configure --prefix=/usr
	make
#	make check
	make install
	rm -fv /usr/lib/libltdl.a

	cd /sources
	rm -fR libtool-2.5.4

}

main

exit 0
