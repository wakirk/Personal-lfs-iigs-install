#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Xz Utils (5.8.1) - 1,428 KB:
	# Home page: https://tukaani.org/xz
	# Download: https://github.com//tukaani-project/xz/releases/download/v5.8.1/xz-5.8.1.tar.xz
	# MD5 sum: cf5e1feb023d22c6bdaa30e84ef3abe3

	echoR "System Software"
	echoL "Downloading Xz Utils (5.8.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com//tukaani-project/xz/releases/download/v5.8.1/xz-5.8.1.tar.xz xz-5.8.1.tar.xz
	cp ../Packages/xz-5.8.1.tar.xz /sources

	echoL "Unpack Xz Utils (5.8.1)..."
	sleep 2
	cd /sources
	rm -fR xz-5.8.1
	tar -vxsf xz-5.8.1.tar.xz
	cd xz-5.8.1

	echoL "Building Xz Utils (5.8.1)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--docdir=/usr/share/doc/xz-5.8.1
	make

	echoL "Installing Xz Utils (5.8.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xz-5.8.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
