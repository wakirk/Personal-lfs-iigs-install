#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	libxcb-1.17.0

	#Optional
	#	Doxygen-1.14.0 (for documentation)

main () {

	# Download (HTTP): https://xcb.freedesktop.org/dist/xcb-util-0.4.1.tar.xz
	# Download MD5 sum: 34d749eab0fd0ffd519ac64798d79847
	# Download size: 261 KB
	# Estimated disk space required: 2.6 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 4 Security Layer"

	echoL "Downloading xcb-util (0.4.1)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://xcb.freedesktop.org/dist/xcb-util-0.4.1.tar.xz xcb-util-0.4.1.tar.xz
	cp ../Packages/xcb-util-0.4.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xcb-util (0.4.1)..."
	sleep 2
	cd /sources
	rm -fR xcb-util-0.4.1
	tar -vxsf xcb-util-0.4.1.tar.xz
	cd xcb-util-0.4.1

	echoL "Building xcb-util (0.4.1)..."
	sleep 2
	./configure $XORG_CONFIG &&
	make

	echoL "Installing xcb-util (0.4.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xcb-util-0.4.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
