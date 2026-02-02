#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Python 3 Dependencies
	# Recommended
	# 	SQLite-3.50.4 (required if building firefox or thunderbird)
	# Optional
	# 	BlueZ-5.83, GDB-16.3 (required for some tests), Valgrind-3.25.1, and libmpdec
	# Optional (For Additional Modules)
	# 	libnsl-2.0.1, Tk-8.6.16, and Berkeley DB (deprecated)

main () {

	# Download (HTTP): https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz
	# Download MD5 sum: 256cdb3bbf45cdce7499e52ba6c36ea3
	# Download size: 22 MB
	# Estimated disk space required: 379 MB (add 59 MB for tests)
	# Estimated build time: 1.5 SBU (add 2.8 SBU for tests; both using parallelism=4)

	# Additional Optional Download
	# Download (HTTP): https://www.python.org/ftp/python/doc/3.13.7/python-3.13.7-docs-html.tar.bz2
	# Download MD5 sum: b84c0d81b2758398bb7f5b7411d3d908
	echoR "Group 1 Library Foundation"

	echoL "Downloading Python (3.13.7)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz Python-3.13.7.tar.xz
	cp ../Packages/Python-3.13.7.tar.xz /sources

	../bash/Download.sh https://www.python.org/ftp/python/doc/3.13.7/python-3.13.7-docs-html.tar.bz2 python-3.13.7-docs-html.tar.bz2
	cp ../Packages/python-3.13.7-docs-html.tar.bz2 /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Python (3.13.7)..."
	sleep 2
	cd /sources
	rm -fR Python-3.13.7
	tar -vxsf Python-3.13.7.tar.xz
	cd Python-3.13.7

	echoL "Building Python (3.13.7)..."
	sleep 2
	./configure --prefix=/usr  \
		--enable-shared        \
		--with-system-expat    \
		--enable-optimizations \
		--without-static-libpython &&
	make

	echoL "Testing Python (3.13.7)..."
	sleep 2
	make test TESTOPTS="--timeout 120"

	echoL "Installing Python (3.13.7)..."
	sleep 2
	make install
	install -v -dm755 /usr/share/doc/python-3.13.7/html
	tar --strip-components=1  \
		--no-same-owner       \
		--no-same-permissions \
		-C /usr/share/doc/python-3.13.7/html \
		-xvf ../python-3.13.7-docs-html.tar.bz2

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR Python-3.13.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
