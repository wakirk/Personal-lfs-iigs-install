#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	cd /sources
	rm -fR bison-3.8.2
	tar -vxsf bison-3.8.2.tar.xz
	cd bison-3.8.2

	./configure --prefix=/usr \
		--docdir=/usr/share/doc/bison-3.8.2
	make
	make install

	rm -fR bison-3.8.2
}

main

exit 0
