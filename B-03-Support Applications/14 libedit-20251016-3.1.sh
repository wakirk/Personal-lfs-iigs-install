#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# External Package
	# Download (HTTP): https://thrysoee.dk/editline/libedit-20251016-3.1.tar.gz
	echoR "Group 3 Support Applications"

	echoL "Downloading libedit (20251016-3.1)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://thrysoee.dk/editline/libedit-20251016-3.1.tar.gz libedit-20251016-3.1.tar.gz
	cp ../Packages/libedit-20251016-3.1.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libedit (20251016-3.1)..."
	sleep 2
	cd /sources
	rm -fR libedit-20251016-3.1
	tar -vxsf libedit-20251016-3.1.tar.gz
	cd libedit-20251016-3.1

	echoL "Building libedit (20251016-3.1)..."
	sleep 2
	autoreconf -fvi
	./configure $XORG_CONFIG
	make

	echoL "Testing libedit (20251016-3.1)..."
	sleep 2
	make check

	echoL "Installing libedit (20251016-3.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libedit-20251016-3.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
