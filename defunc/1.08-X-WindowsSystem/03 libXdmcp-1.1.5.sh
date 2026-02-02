#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libXdmcp-1.1.5
	# Download (HTTP): https://www.x.org/pub/individual/lib/libXdmcp-1.1.5.tar.xz
	# Download MD5 sum: ce0af51de211e4c99a111e64ae1df290
	# Download size: 292 KB
	# Estimated disk space required: 3.0 MB (with test)
	# Estimated build time: less than 0.1 SBU (with test)
	echoR "System Software"

	echoL "Downloading libXdmcp (1.1.5)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/libXdmcp-1.1.5.tar.xz libXdmcp-1.1.5.tar.xz
	cp ../Packages/libXdmcp-1.1.5.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libXdmcp (1.1.5)..."
	sleep 2
	cd /sources
	rm -fR libXdmcp-1.1.5
	tar -vxsf libXdmcp-1.1.5.tar.xz
	cd libXdmcp-1.1.5

	echoL "Building libXdmcp (1.1.5)..."
	sleep 2
	./configure $XORG_CONFIG --docdir=/usr/share/doc/libXdmcp-1.1.5
	make

	echoL "Installing libXdmcp (1.1.5)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libXdmcp-1.1.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
