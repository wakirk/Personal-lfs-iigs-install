#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libXxf86vm (1.1.6)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libXaw-1.0.16.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading libXaw (1.0.16)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libXaw-1.0.16.tar.xz libXaw-1.0.16.tar.xz
	cp ../Packages/libXaw-1.0.16.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libXaw (1.0.16)..."
	sleep 2
	cd /sources
	rm -fR libXaw-1.0.16
	tar -vxsf libXaw-1.0.16.tar.xz
	cd libXaw-1.0.16

	echoL "Building libXaw (1.0.16)..."
	sleep 2
	packagedir="libXaw-1.0.16"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make
	/bin/bash

	echoL "Installing libXaw (1.0.16)..."
	sleep 2
	# make install
	# /sbin/ldconfig
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libXaw-1.0.16

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
