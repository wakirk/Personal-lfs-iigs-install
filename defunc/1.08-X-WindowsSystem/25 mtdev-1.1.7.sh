#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://bitmath.org/code/mtdev/mtdev-1.1.7.tar.bz2
	# Download MD5 sum: 483ed7fdf7c1e7b7375c05a62848cce7
	# Download size: 296 KB
	# Estimated disk space required: 2.5 MB
	# Estimated build time: less than 0.1 SBU
	echoR "System Software"

	echoL "Downloading mtdev (1.1.7)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://bitmath.org/code/mtdev/mtdev-1.1.7.tar.bz2 mtdev-1.1.7.tar.bz2
	cp ../Packages/mtdev-1.1.7.tar.bz2 /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack mtdev (1.1.7)..."
	sleep 2
	cd /sources
	rm -fR mtdev-1.1.7
	tar -vxsf mtdev-1.1.7.tar.bz2
	cd mtdev-1.1.7

	echoL "Building mtdev (1.1.7)..."
	sleep 2
	./configure --prefix=/usr --disable-static &&
	make

	echoL "Installing mtdev (1.1.7)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR mtdev-1.1.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
