#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libXxf86vm (1.1.6)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libXfont2-2.0.7.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading libXfont2 (2.0.7)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libXfont2-2.0.7.tar.xz libXfont2-2.0.7.tar.xz
	cp ../Packages/libXfont2-2.0.7.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libXfont2 (2.0.7)..."
	sleep 2
	cd /sources
	rm -fR libXfont2-2.0.7
	tar -vxsf libXfont2-2.0.7.tar.xz
	cd libXfont2-2.0.7

	echoL "Building libXfont2 (2.0.7)..."
	sleep 2
	packagedir="libXfont2-2.0.7"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make

	echoL "Installing libXfont2 (2.0.7)..."
	sleep 2
	make install
	/sbin/ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libXfont2-2.0.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
