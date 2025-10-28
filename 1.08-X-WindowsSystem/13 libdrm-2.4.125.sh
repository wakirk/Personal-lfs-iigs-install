#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://dri.freedesktop.org/libdrm/libdrm-2.4.125.tar.xz
	# Download MD5 sum: 3baec8e685510892b3355a7074baa874
	# Download size: 476 KB
	# Estimated disk space required: 12 MB (with tests)
	# Estimated build time: 0.1 SBU (with tests)
	echoR "System Software"

	echoL "Downloading libdrm (2.4.125)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://dri.freedesktop.org/libdrm/libdrm-2.4.125.tar.xz libdrm-2.4.125.tar.xz
	cp ../Packages/libdrm-2.4.125.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libdrm (2.4.125)..."
	sleep 2
	cd /sources
	rm -fR libdrm-2.4.125
	tar -vxsf libdrm-2.4.125.tar.xz
	cd libdrm-2.4.125

	echoL "Building libdrm (2.4.125)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=$XORG_PREFIX \
	--buildtype=release               \
	-D udev=true                      \
	-D valgrind=disabled ..
	ninja

	echoL "Installing libdrm (2.4.125)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libdrm-2.4.125

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
