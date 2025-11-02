#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	#	libunistring Dependencies
	#	Optional
	#		texlive-20250308 (or install-tl-unx) (to rebuild the documentation)

main () {

	# Package Information
	# Download (HTTP): https://ftp.gnu.org/gnu/libunistring/libunistring-1.3.tar.xz
	# Download MD5 sum: 57dfd9e4eba93913a564aa14eab8052e
	# Download size: 2.6 MB
	# Estimated disk space required: 58 MB (add 46 MB for tests)
	# Estimated build time: 0.6 SBU (add 0.3 SBU for tests; both using parallelism=4)
	echoR "Group 1 Library Foundation"

	echoL "Downloading Libunistring (1.3)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://ftp.gnu.org/gnu/libunistring/libunistring-1.3.tar.xz libunistring-1.3.tar.xz
	cp ../Packages/libunistring-1.3.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Libunistring (1.3)..."
	sleep 2
	cd /sources
	rm -fR libunistring-1.3
	tar -vxsf libunistring-1.3.tar.xz
	cd libunistring-1.3

	echoL "Building Libunistring (1.3)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--docdir=/usr/share/doc/libunistring-1.3 &&
	make

	echoL "Installing Libunistring (1.3)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libunistring-1.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
