#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	cd /sources
	rm -fR texinfo-7.2
	tar -vxsf texinfo-7.2.tar.xz
	cd texinfo-7.2

	./configure --prefix=/usr
	make
	make install

	rm -fR texinfo-7.2
}

main

exit 0
