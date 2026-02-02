#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# xbitmaps Dependencies
	# Required
	#	util-macros-1.20.2

main () {

	# Download (HTTP): https://www.x.org/pub/individual/data/xbitmaps-1.1.3.tar.xz
	# Download MD5 sum: 2b03f89d78fb91671370e77d7ad46907
	# Download size: 108 KB
	# Estimated disk space required: 1.6 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 3 Support Applications"

	echoL "Downloading xbitmaps (1.1.3)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://www.x.org/pub/individual/data/xbitmaps-1.1.3.tar.xz xbitmaps-1.1.3.tar.xz
	cp ../Packages/xbitmaps-1.1.3.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xbitmaps (1.1.3)..."
	sleep 2
	cd /sources
	rm -fR xbitmaps-1.1.3
	tar -vxsf xbitmaps-1.1.3.tar.xz
	cd xbitmaps-1.1.3

	echoL "Building xbitmaps (1.1.3)..."
	sleep 2
	./configure $XORG_CONFIG

	echoL "Installing xbitmaps (1.1.3)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xbitmaps-1.1.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
