#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libX11-1.8.12.tar.xz
	# Download (HTTP): https://www.x.org/pub/individual/lib/libX11-1.8.12.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU	echoR "System Software"
	echoL "Downloading libX11 (1.8.12)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libX11-1.8.12.tar.xz libX11-1.8.12.tar.xz
	cp ../Packages/libX11-1.8.12.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libX11 (1.8.12)..."
	sleep 2
	cd /sources
	rm -fR libX11-1.8.12
	tar -vxsf libX11-1.8.12.tar.xz
	cd libX11-1.8.12

	echoL "Building libX11 (1.8.12)..."
	sleep 2
	packagedir="libX11-1.8.12"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make

	echoL "Testing libX11 (1.8.12)..."
	sleep 2

	echoL "Installing libX11 (1.8.12)..."
	sleep 2
	make install
	/sbin/ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libX11-1.8.12

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
