#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libXxf86vm (1.1.6)
	# Download (HTTP): https://www.x.org/pub/individual/lib/libXxf86vm-1.1.6.tar.xz
	# Download size: 12 MB
	# Estimated disk space required: 274 MB (47 MB installed) - if source directories not deleted
	# Estimated build time: 1.8 SBU
	echoR "System Software"

	echoL "Downloading ---- ( )..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/  *.tar.xz
	cp ../Packages/-*.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack ---- ( )..."
	sleep 2
	cd /sources
	rm -fR 
	tar -vxsf #*.tar.xz
	cd 

	echoL "Building ---- ( )..."
	sleep 2
	packagedir="--------"
	docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
	./configure $XORG_CONFIG $docdir
	make
	/bin/bash

	echoL "Installing ---- ( )..."
	sleep 2
	# make install
	# /sbin/ldconfig
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR #

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
