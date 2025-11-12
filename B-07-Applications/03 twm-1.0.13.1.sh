#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	Xorg-Server-21.1.18

main () {

	# Download (HTTP): https://www.x.org/pub/individual/app/twm-1.0.13.1.tar.xz
	# Download MD5 sum: 2a337b776c904eab5b874eddc0124d4f
	# Download size: 268 KB
	# Estimated disk space required: 3.8 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 7 Applications"

	echoL "Downloading twm (1.0.13.1)..."
	sleep 2
	cd "/root/lfs/B-07-Applications"
	../bash/Download.sh https://www.x.org/pub/individual/app/twm-1.0.13.1.tar.xz twm-1.0.13.1.tar.xz
	cp ../Packages/twm-1.0.13.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack twm (1.0.13.1)..."
	sleep 2
	cd /sources
	rm -fR twm-1.0.13.1
	tar -vxsf twm-1.0.13.1.tar.xz
	cd twm-1.0.13.1

	echoL "Building twm (1.0.13.1)..."
	sleep 2
	sed -i -e '/^rcdir =/s,^\(rcdir = \).*,\1/etc/X11/app-defaults,' src/Makefile.in &&
	./configure $XORG_CONFIG &&
	make

	echoL "Installing twm (1.0.13.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR twm-1.0.13.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
