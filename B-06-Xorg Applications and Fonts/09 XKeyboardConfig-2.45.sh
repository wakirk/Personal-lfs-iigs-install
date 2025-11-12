#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	Xorg Libraries

	# Optional (required for tests)
	#	libxkbcommon-1.11.0
	#	pytest-8.4.1
	#	Xorg Applications

main () {

	# Download (HTTP): https://www.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.45.tar.xz
	# Download MD5 sum: cebc84ec99d3273e07aee8ecff3e3519
	# Download size: 896 KB
	# Estimated disk space required: 22 MB
	# Estimated build time: 0.1 SBU (with tests)
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading X Keyboard Config (2.45)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://www.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.45.tar.xz xkeyboard-config-2.45.tar.xz
	cp ../Packages/xkeyboard-config-2.45.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack X Keyboard Config (2.45)..."
	sleep 2
	cd /sources
	rm -fR xkeyboard-config-2.45
	tar -vxsf xkeyboard-config-2.45.tar.xz
	cd xkeyboard-config-2.45

	echoL "Building X Keyboard Config (2.45)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=$XORG_PREFIX --buildtype=release ..
	ninja
	read

	echoL "Installing X Keyboard Config (2.45)..."
	sleep 2
	ninja install
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xkeyboard-config-2.45

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
