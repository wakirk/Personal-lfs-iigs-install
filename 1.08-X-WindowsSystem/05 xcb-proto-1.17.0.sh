#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# xcb-proto-1.17.0
	# Download (HTTP): https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-1.17.0.tar.xz
	# Download MD5 sum: c415553d2ee1a8cea43c3234a079b53f
	# Download size: 152 KB
	# Estimated disk space required: 1.3 MB
	# Estimated build time: less than 0.1 SBU	echoR "System Software"
	echoL "Downloading xcb-proto (1.17.0)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-1.17.0.tar.xz xcb-proto-1.17.0.tar.xz
	cp ../Packages/xcb-proto-1.17.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xcb-proto (1.17.0)..."
	sleep 2
	cd /sources
	rm -fR xcb-proto-1.17.0
	tar -vxsf xcb-proto-1.17.0.tar.xz
	cd xcb-proto-1.17.0

	echoL "Building xcb-proto (1.17.0)..."
	sleep 2
	PYTHON=python3 ./configure $XORG_CONFIG

	echoL "Installing xcb-proto (1.17.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xcb-proto-1.17.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
