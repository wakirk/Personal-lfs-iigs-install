#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	cd /sources
	rm -fR Python-3.13.7
	tar -vxsf Python-3.13.7.tar.xz
	cd Python-3.13.7

	./configure --prefix=/usr \
		--enable-shared       \
		--without-ensurepip   \
		--without-static-libpython
	make
	make install

	rm -fR Python-3.13.7

}

main

exit 0
