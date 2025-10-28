#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libpciaccess (0.18.1)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libpciaccess-0.18.1.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading libpciaccess (0.18.1)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libpciaccess-0.18.1.tar.xz libpciaccess-0.18.1.tar.xz
	cp ../Packages/libpciaccess-0.18.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libpciaccess (0.18.1)..."
	sleep 2
	cd /sources
	rm -fR libpciaccess-0.18.1
	tar -vxsf libpciaccess-0.18.1.tar.xz
	cd libpciaccess-0.18.1

	echoL "Building libpciaccess (0.18.1)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=$XORG_PREFIX --buildtype=release ..
	ninja

	echoL "Installing libpciaccess (0.18.1)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libpciaccess-0.18.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
