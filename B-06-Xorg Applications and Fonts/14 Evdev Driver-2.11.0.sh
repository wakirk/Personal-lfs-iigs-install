#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	libevdev-1.13.4
	#	mtdev-1.1.7
	#	Xorg-Server-21.1.18

main () {

	# Package Information: https://www.linuxfromscratch.org/blfs/view/stable/x/x7driver.html#xorg-evdev-driver
	# Download (HTTP): https://www.x.org/pub/individual/driver/xf86-input-evdev-2.11.0.tar.xz
	# Download MD5 sum: faa89be0ef86aebd6fd0a03eed23839c
	# Download size: 344 KB
	# Estimated disk space required: 3.7 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading Evdev Driver (2.11.0)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://www.x.org/pub/individual/driver/xf86-input-evdev-2.11.0.tar.xz xf86-input-evdev-2.11.0.tar.xz
	cp ../Packages/xf86-input-evdev-2.11.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Evdev Driver (2.11.0)..."
	sleep 2
	cd /sources
	rm -fR xf86-input-evdev-2.11.0
	tar -vxsf xf86-input-evdev-2.11.0.tar.xz
	cd xf86-input-evdev-2.11.0

	echoL "Building Evdev Driver (2.11.0)..."
	sleep 2
	./configure $XORG_CONFIG &&
	make

	echoL "Installing Evdev Driver (2.11.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xf86-input-evdev-2.11.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
