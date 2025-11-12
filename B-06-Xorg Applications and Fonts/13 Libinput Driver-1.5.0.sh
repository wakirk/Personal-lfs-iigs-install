#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	libinput-1.29.0
	#	Xorg-Server-21.1.18

main () {

	# Package Information: https://www.linuxfromscratch.org/blfs/view/stable/x/x7driver.html#xorg-libinput-driver
	# Download (HTTP): https://www.x.org/pub/individual/driver/xf86-input-libinput-1.5.0.tar.xz
	# Download MD5 sum: f8d0fb6987d843e688d597c2b66ec824
	# Download size: 324 KB
	# Estimated disk space required: 3.9 MB (with tests)
	# Estimated build time: less than 0.1 SBU (with tests)
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading Libinput Driver (1.5.0)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://www.x.org/pub/individual/driver/xf86-input-libinput-1.5.0.tar.xz xf86-input-libinput-1.5.0.tar.xz
	cp ../Packages/xf86-input-libinput-1.5.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Libinput Driver (1.5.0)..."
	sleep 2
	cd /sources
	rm -fR xf86-input-libinput-1.5.0
	tar -vxsf xf86-input-libinput-1.5.0.tar.xz
	cd xf86-input-libinput-1.5.0

	echoL "Building Libinput Driver (1.5.0)..."
	sleep 2
	./configure $XORG_CONFIG
	make
	read

	echoL "Testing Libinput Driver (1.5.0)..."
	sleep 2
	make check
	read

	echoL "Installing Libinput Driver (1.5.0)..."
	sleep 2
	make install
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xf86-input-libinput-1.5.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
