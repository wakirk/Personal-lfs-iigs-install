#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libtirpc (1.3.6)
	# Download (HTTP): https://downloads.sourceforge.net/libtirpc/libtirpc-1.3.6.tar.bz2
	# Download MD5 sum: 8de9e6af16c4bc65ba40d0924745f5b7
	# Download size: 553 KB
	# Estimated disk space required: 7.4 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 1 Library Foundation"

	echoL "Downloading libtirpc (1.3.6)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://downloads.sourceforge.net/libtirpc/libtirpc-1.3.6.tar.bz2 libtirpc-1.3.6.tar.bz2
	cp ../Packages/libtirpc-1.3.6.tar.bz2 /sources
	../bash/Download.sh https://www.linuxfromscratch.org/patches/blfs/12.4/libtirpc-1.3.6-gcc15_fixes-1.patch libtirpc-1.3.6-gcc15_fixes-1.patch
	cp ../Packages/libtirpc-1.3.6-gcc15_fixes-1.patch /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libtirpc (1.3.6)..."
	sleep 2
	cd /sources
	rm -fR libtirpc-1.3.6
	tar -vxsf libtirpc-1.3.6.tar.bz2
	cd libtirpc-1.3.6

	echoL "Building libtirpc (1.3.6)..."
	sleep 2
	patch -Np1 -i ../libtirpc-1.3.6-gcc15_fixes-1.patch
	./configure --prefix=/usr     \
				--sysconfdir=/etc \
				--disable-static  \
				--disable-gssapi
	make

	echoL "Installing libtirpc (1.3.6)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libtirpc-1.3.6

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
