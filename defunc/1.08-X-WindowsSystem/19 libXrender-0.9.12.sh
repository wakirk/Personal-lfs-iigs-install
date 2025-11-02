#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libXrender (0.9.12)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libXrender-0.9.12.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading libXrender (0.9.12)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libXrender-0.9.12.tar.xz libXrender-0.9.12.tar.xz
	cp ../Packages/libXrender-0.9.12.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libXrender (0.9.12)..."
	sleep 2
	cd /sources
	rm -fR libXrender-0.9.12
	tar -vxsf libXrender-0.9.12.tar.xz
	cd libXrender-0.9.12

	echoL "Building libXrender (0.9.12)..."
	sleep 2
	packagedir="libXrender-0.9.12"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make

	echoL "Installing libXrender (0.9.12)..."
	sleep 2
	make install
	/sbin/ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libXrender-0.9.12

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
