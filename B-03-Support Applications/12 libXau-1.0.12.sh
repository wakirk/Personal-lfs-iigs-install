#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# libXau Dependencies
	#	Required
	#	xorgproto-2024.1

main () {

	# Download (HTTP): https://www.x.org/pub/individual/lib/libXau-1.0.12.tar.xz
	# Download MD5 sum: 4c9f81acf00b62e5de56a912691bd737
	# Download size: 276 KB
	# Estimated disk space required: 2.9 MB (with test)
	# Estimated build time: less than 0.1 SBU (with test)
	echoR "Group 3 Support Applications"

	echoL "Downloading libXau (1.0.12)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libXau-1.0.12.tar.xz libXau-1.0.12.tar.xz
	cp ../Packages/libXau-1.0.12.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libXau (1.0.12)..."
	sleep 2
	cd /sources
	rm -fR libXau-1.0.12
	tar -vxsf libXau-1.0.12.tar.xz
	cd libXau-1.0.12

	echoL "Building libXau (1.0.12)..."
	sleep 2
	./configure $XORG_CONFIG &&
	make

	echoL "Testing libXau (1.0.12)..."
	sleep 2
	make check

	echoL "Installing libXau (1.0.12)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libXau-1.0.12

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
