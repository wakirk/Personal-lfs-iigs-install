#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libxshmfence (1.3.3)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libxshmfence-1.3.3.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading libxshmfence (1.3.3)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libxshmfence-1.3.3.tar.xz libxshmfence-1.3.3.tar.xz
	cp ../Packages/libxshmfence-1.3.3.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libxshmfence (1.3.3)..."
	sleep 2
	cd /sources
	rm -fR libxshmfence-1.3.3
	tar -vxsf libxshmfence-1.3.3.tar.xz
	cd libxshmfence-1.3.3

	echoL "Building libxshmfence (1.3.3)..."
	sleep 2
	packagedir="libxshmfence-1.3.3"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make

	echoL "Installing libxshmfence (1.3.3)..."
	sleep 2
	make install
	/sbin/ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libxshmfence-1.3.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
