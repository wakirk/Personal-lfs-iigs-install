#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# 4. xtrans	xtrans — Transport-abstraction macros used by X libs for TCP/Unix-socket I/O.
	# https://www.linuxfromscratch.org/blfs/view/stable/x/x7lib.html
	echoR "System Software"

	echoL "Downloading xtrans (1.6.0)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/lib/xtrans-1.6.0.tar.xz xtrans-1.6.0.tar.xz
	cp ../Packages/xtrans-1.6.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xtrans (1.6.0)..."
	sleep 2
	cd /sources
	rm -fR xtrans-1.6.0
	tar -vxsf xtrans-1.6.0.tar.xz
	cd xtrans-1.6.0

	echoL "Building xtrans (1.6.0)..."
	sleep 2
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/xtrans-1.6.0

	echoL "Installing xtrans (1.6.0)..."
	sleep 2
	make install
	/sbin/ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xtrans-1.6.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
