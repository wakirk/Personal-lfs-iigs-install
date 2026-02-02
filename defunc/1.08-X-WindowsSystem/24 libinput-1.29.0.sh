#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://gitlab.freedesktop.org/libinput/libinput/-/archive/1.29.0/libinput-1.29.0.tar.gz
	# Download MD5 sum: 7c243cf456aff35b57412527ee8143e4
	# Download size: 1.1 MB
	# Estimated disk space required: 13 MB (add 35 MB for documentation and 9 MB for minor tests)
	# Estimated build time: 0.1 SBU (add 0.1 SBU for documentation and 0.3 SBU for minor tests)
	echoR "System Software"

	echoL "Downloading libinput (1.29.0)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://gitlab.freedesktop.org/libinput/libinput/-/archive/1.29.0/libinput-1.29.0.tar.gz libinput-1.29.0.tar.gz
	cp ../Packages/libinput-1.29.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libinput (1.29.0)..."
	sleep 2
	cd /sources
	rm -fR libinput-1.29.0
	tar -vxsf libinput-1.29.0.tar.gz
	cd libinput-1.29.0

	echoL "Building libinput (1.29.0)..."
	sleep 2
	mkdir build
	cd    build
	meson setup ..        \
	--prefix=$XORG_PREFIX \
	--buildtype=release   \
	-D debug-gui=false    \
	-D tests=false        \
	-D libwacom=false     \
	-D udev-dir=/usr/lib/udev
	ninja

	echoL "Installing libinput (1.29.0)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libinput-1.29.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
