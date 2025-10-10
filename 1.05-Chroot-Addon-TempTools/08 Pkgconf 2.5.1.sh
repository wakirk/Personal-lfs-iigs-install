#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	cd /sources
	rm -fR pkgconf-2.5.1
	tar -vxsf pkgconf-2.5.1.tar.xz
	cd pkgconf-2.5.1

	./configure --prefix=/usr    \
		--disable-static \
		--docdir=/usr/share/doc/pkgconf-2.5.1
	make
	make install

	ln -sv pkgconf   /usr/bin/pkg-config
	ln -sv pkgconf.1 /usr/share/man/man1/pkg-config.1

	cd /sources
	rm -fR pkgconf-2.5.1

}

main

exit 0
