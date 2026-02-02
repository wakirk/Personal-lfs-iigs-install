#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	cd /sources
	rm -fR openssl-3.6.0
	tar -vxsf openssl-3.6.0.tar.gz
	cd openssl-3.6.0

	./Configure --prefix=/usr --openssldir=/etc/ssl --libdir=lib shared
	make
#	make test
	make install

	cd /sources
	rm -fR openssl-3.6.0

}

main

exit 0
