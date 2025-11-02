#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# libxcb-1.17.0
	# Download (HTTP): https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.17.0.tar.xz
	# Download MD5 sum: 96565523e9f9b701fcb35d31f1d4086e
	# Download size: 448 KB
	# Estimated disk space required: 30 MB (with tests, add 62 MB for doxygen docs)
	# Estimated build time: 0.2 SBU (with tests, add 1.4 SBU for doxygen docs)
	echoR "System Software"

	echoL "Downloading libxcb (1.17.0)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.17.0.tar.xz libxcb-1.17.0.tar.xz
	cp ../Packages/libxcb-1.17.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libxcb (1.17.0)..."
	sleep 2
	cd /sources
	rm -fR libxcb-1.17.0
	tar -vxsf libxcb-1.17.0.tar.xz
	cd libxcb-1.17.0

	echoL "Building libxcb (1.17.0)..."
	sleep 2
	./configure $XORG_CONFIG \
		--without-doxygen    \
		--docdir='${datadir}'/doc/libxcb-1.17.0 &&
	LC_ALL=en_US.UTF-8 make

	echoL "Testing libxcb (1.17.0)..."
	sleep 2
	make check.
#	/bin/bash

	echoL "Installing libxcb (1.17.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libxcb-1.17.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
