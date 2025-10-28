#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libXrandr (1.5.4)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libXrandr-1.5.4.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading libXrandr (1.5.4)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libXrandr-1.5.4.tar.xz libXrandr-1.5.4.tar.xz
	cp ../Packages/libXrandr-1.5.4.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libXrandr (1.5.4)..."
	sleep 2
	cd /sources
	rm -fR libXrandr-1.5.4
	tar -vxsf libXrandr-1.5.4.tar.xz
	cd libXrandr-1.5.4

	echoL "Building libXrandr (1.5.4)..."
	sleep 2
	packagedir="libXrandr-1.5.4"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make

	echoL "Installing libXrandr (1.5.4)..."
	sleep 2
	make install
	/sbin/ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libXrandr-1.5.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
