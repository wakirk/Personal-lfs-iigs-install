#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	cd /sources 
	rm -fR libevent-release-2.1.12-stable
	tar -vxsf libevent-2.1.12.tar.gz
	cd libevent-release-2.1.12-stable

	./autogen.sh
	./configure --prefix=/usr --sysconfdir=/etc --disable-shared --disable-thread-support --disable-openssl
	/bin/bash
	make
	make install 

	cd /sources
	rm -fR libevent-release-2.1.12-stable

}

main

exit 0
