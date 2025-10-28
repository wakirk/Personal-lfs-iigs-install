#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Package Information
	# Download (HTTP): https://www.x.org/pub/individual/lib/libxcvt-0.1.3.tar.xz
	# Download MD5 sum: 7fb9c51d33a680f724f34da41768b1d0
	# Download size: 12 KB
	# Estimated disk space required: 440 KB
	# Estimated build time: less than 0.1 SBU
	echoR "System Software"

	echoL "Downloading libxcvt (0.1.3)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libxcvt-0.1.3.tar.xz libxcvt-0.1.3.tar.xz
	cp ../Packages/libxcvt-0.1.3.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libxcvt (0.1.3)..."
	sleep 2
	cd /sources
	rm -fR libxcvt-0.1.3
	tar -vxsf libxcvt-0.1.3.tar.xz
	cd libxcvt-0.1.3

	echoL "Building libxcvt (0.1.3)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=$XORG_PREFIX --buildtype=release .. &&
	ninja

	echoL "Installing libxcvt (0.1.3)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libxcvt-0.1.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
