#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://www.x.org/pub/individual/app/xkbcomp-1.4.7.tar.xz
	# Download size: 4.9 MB
	# Estimated disk space required: 48 MB
	# Estimated build time: 1.5 SBU (ignoring the time to download)
	echoR "System Software"

	echoL "Downloading xkbcomp (1.4.7)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/app/xkbcomp-1.4.7.tar.xz xkbcomp-1.4.7.tar.xz
	cp ../Packages/xkbcomp-1.4.7.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xkbcomp (1.4.7)..."
	sleep 2
	cd /sources
	rm -fR xkbcomp-1.4.7
	tar -vxsf xkbcomp-1.4.7.tar.xz
	cd xkbcomp-1.4.7

	echoL "Building xkbcomp (1.4.7)..."
	sleep 2
	./configure $XORG_CONFIG
	make

	echoL "Installing xkbcomp (1.4.7)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xkbcomp-1.4.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
