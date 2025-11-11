#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://www.x.org/pub/individual/data/xcursor-themes-1.0.7.tar.xz
	# Download MD5 sum: 070993be1f010b09447ea24bab2c9846
	# Download size: 1.4 MB
	# Estimated disk space required: 15 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading X cursor themes (1.0.7)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://www.x.org/pub/individual/data/xcursor-themes-1.0.7.tar.xz xcursor-themes-1.0.7.tar.xz
	cp ../Packages/xcursor-themes-1.0.7.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack X cursor themes (1.0.7)..."
	sleep 2
	cd /sources
	rm -fR xcursor-themes-1.0.7
	tar -vxsf xcursor-themes-1.0.7.tar.xz
	cd xcursor-themes-1.0.7

	echoL "Building X cursor themes (1.0.7)..."
	sleep 2
	./configure --prefix=/usr &&
	make

	echoL "Installing X cursor themes (1.0.7)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xcursor-themes-1.0.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
