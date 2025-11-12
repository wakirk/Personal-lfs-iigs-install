#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Optional
	#	Doxygen-1.14.0
	#	Valgrind-3.25.1 (optional for tests),
	#	check (required for tests)

main () {

	# Package Information: https://www.linuxfromscratch.org/blfs/view/stable/x/x7driver.html#libevdev
	# Download (HTTP): https://www.freedesktop.org/software/libevdev/libevdev-1.13.4.tar.xz
	# Download MD5 sum: 2e8a4665e332699ccba7ee54a0dd189a
	# Download size: 456 KB
	# Estimated disk space required: 6.2 MB (with tests)
	# Estimated build time: less than 0.1 SBU (with tests)
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading libevdev (1.13.4)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://www.freedesktop.org/software/libevdev/libevdev-1.13.4.tar.xz libevdev-1.13.4.tar.xz
	cp ../Packages/libevdev-1.13.4.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libevdev (1.13.4)..."
	sleep 2
	cd /sources
	rm -fR libevdev-1.13.4
	tar -vxsf libevdev-1.13.4.tar.xz
	cd libevdev-1.13.4

	echoL "Building libevdev (1.13.4)..."
	sleep 2
	mkdir build
	cd    build
	meson setup ..                \
		--prefix=$XORG_PREFIX     \
		--buildtype=release       \
		-D documentation=disabled \
		-D tests=disabled
	ninja

	echoL "Installing libevdev (1.13.4)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libevdev-1.13.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
