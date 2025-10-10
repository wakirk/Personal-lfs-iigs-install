#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	cd /sources 
	rm -fR wget-1.25.0
	tar -vxsf wget-1.25.0.tar.gz
	cd wget-1.25.0

	./configure --prefix=/usr --sysconfdir=/etc --with-ssl=openssl
	make
	make install
	read

	cd /sources
	rm -fR wget-1.25.0

}

main

exit 0
