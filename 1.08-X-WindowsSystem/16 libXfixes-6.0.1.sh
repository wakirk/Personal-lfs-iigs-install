#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libXfixes (6.0.1)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libXfixes-6.0.1.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading libXfixes (6.0.1)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libXfixes-6.0.1.tar.xz libXfixes-6.0.1.tar.xz
	cp ../Packages/libXfixes-6.0.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libXfixes (6.0.1)..."
	sleep 2
	cd /sources
	rm -fR libXfixes-6.0.1
	tar -vxsf libXfixes-6.0.1.tar.xz
	cd libXfixes-6.0.1

	echoL "Building libXfixes (6.0.1)..."
	sleep 2
	packagedir="libXfixes-6.0.1"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make

	echoL "Installing libXfixes (6.0.1)..."
	sleep 2
	make install
	/sbin/ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libXfixes-6.0.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
