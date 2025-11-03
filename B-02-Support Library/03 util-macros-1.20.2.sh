#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

#util-macros Dependencies
#	Required
#	Xorg build environment (should be set for the following instructions to work)

main () {

	# Download (HTTP): https://www.x.org/pub/individual/util/util-macros-1.20.2.tar.xz
	# Download MD5 sum: 5f683a1966834b0a6ae07b3680bcb863
	# Download size: 84 KB
	# Estimated disk space required: 524 KB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 2 Support Library"

	echoL "Downloading util-macros (1.20.2)..."
	sleep 2
	cd "/root/lfs/B-02-Support Library"
	../bash/Download.sh https://www.x.org/pub/individual/util/util-macros-1.20.2.tar.xz util-macros-1.20.2.tar.xz
	cp ../Packages/util-macros-1.20.2.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack util-macros (1.20.2)..."
	sleep 2
	cd /sources
	rm -fR util-macros-1.20.2
	tar -vxsf util-macros-1.20.2.tar.xz
	cd util-macros-1.20.2

	echoL "Building util-macros (1.20.2)..."
	sleep 2
	./configure $XORG_CONFIG

	echoL "Installing util-macros (1.20.2)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR util-macros-1.20.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
