#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	cd /sources
	rm -fR gettext-0.26
	tar -vxsf gettext-0.26.tar.xz
	cd gettext-0.26

	./configure --disable-shared
	make
	cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin

	cd /sources
	rm -fR gettext-0.26

}

main

exit 0
