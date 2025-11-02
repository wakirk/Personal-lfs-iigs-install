#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libXxf86vm (1.1.6)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libxkbfile-1.1.3.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading libxkbfile (1.1.3)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libxkbfile-1.1.3.tar.xz libxkbfile-1.1.3.tar.xz
	cp ../Packages/libxkbfile-1.1.3.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libxkbfile (1.1.3)..."
	sleep 2
	cd /sources
	rm -fR libxkbfile-1.1.3
	tar -vxsf libxkbfile-1.1.3.tar.xz
	cd libxkbfile-1.1.3

	echoL "Building libxkbfile (1.1.3)..."
	sleep 2
	packagedir="libxkbfile-1.1.3"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make

	echoL "Installing libxkbfile (1.1.3)..."
	sleep 2
	make install
	/sbin/ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libxkbfile-1.1.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
