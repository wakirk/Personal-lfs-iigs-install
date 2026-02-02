#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Package Information
	# Download (HTTP): https://www.x.org/pub/individual/font/font-util-1.4.1.tar.xz
	# Download size: 3.0 MB
	# Estimated disk space required: 8.8 MB
	# Estimated build time: 0.1 SBU
	echoR "System Software"

	echoL "Downloading font-util (1.4.1)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/font/font-util-1.4.1.tar.xz font-util-1.4.1.tar.xz
	cp ../Packages/font-util-1.4.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack font-util (1.4.1)..."
	sleep 2
	cd /sources
	rm -fR font-util-1.4.1
	tar -vxsf font-util-1.4.1.tar.xz
	cd font-util-1.4.1

	echoL "Building font-util (1.4.1)..."
	sleep 2
	./configure $XORG_CONFIG
	make

	echoL "Installing font-util (1.4.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR font-util-1.4.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
