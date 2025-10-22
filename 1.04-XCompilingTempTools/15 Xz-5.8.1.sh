#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Xz Utils (5.8.1) - 1,428 KB:
#Home page: https://tukaani.org/xz
#Download: https://github.com//tukaani-project/xz/releases/download/v5.8.1/xz-5.8.1.tar.xz
#MD5 sum: cf5e1feb023d22c6bdaa30e84ef3abe3

main () {
	clear
	echoR "Installing Software Xz Utils (5.8.1)"
	echoL "Downloading Xz Utils (5.8.1)..."

	echo "Downloading Xz Utils (5.8.1)..."
	../bash/Download.sh https://github.com//tukaani-project/xz/releases/download/v5.8.1/xz-5.8.1.tar.xz xz-5.8.1.tar.xz
	cp ../Packages/xz-5.8.1.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Xz Utils (5.8.1)..."
	sleep 2
	rm -fR xz-5.8.1
	tar -vxsf xz-5.8.1.tar.xz
	cd xz-5.8.1

	echoL "Building Xz Utils (5.8.1)..."
	./configure --prefix=/usr             \
		--host=$LFS_TGT                   \
		--build=$(build-aux/config.guess) \
		--disable-static                  \
		--docdir=/usr/share/doc/xz-5.8.1
	make

	echoL "Installing Xz Utils (5.8.1)..."
	make DESTDIR=$LFS install
	rm -v $LFS/usr/lib/liblzma.la

	echoL "Install Complete Xz Utils (5.8.1)"
	sleep 2
	cd $LFS/sources
	rm -fR xz-5.8.1

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
