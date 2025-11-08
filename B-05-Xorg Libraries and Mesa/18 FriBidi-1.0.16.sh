#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Optional
	#	c2man (to build man pages)

main () {

	# Download (HTTP): https://github.com/fribidi/fribidi/releases/download/v1.0.16/fribidi-1.0.16.tar.xz
	# Download MD5 sum: 333ad150991097a627755b752b87f9ff
	# Download size: 1.1 MB
	# Estimated disk space required: 22 MB (with tests)
	# Estimated build time: less than 0.1 SBU (with tests)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading FriBidi (1.0.16)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/fribidi/fribidi/releases/download/v1.0.16/fribidi-1.0.16.tar.xz fribidi-1.0.16.tar.xz
	cp ../Packages/fribidi-1.0.16.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack FriBidi (1.0.16)..."
	sleep 2
	cd /sources
	rm -fR fribidi-1.0.16
	tar -vxsf fribidi-1.0.16.tar.xz
	cd fribidi-1.0.16

	echoL "Building FriBidi (1.0.16)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=/usr --buildtype=release ..
	ninja

	echoL "Testing FriBidi (1.0.16)..."
	sleep 2
	ninja test

	echoL "Installing FriBidi (1.0.16)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR fribidi-1.0.16

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
