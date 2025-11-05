#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	#xorgproto Dependencies
	#Required
	#	util-macros-1.20.2

	# Optional
	#	fop-2.11
	#	libxslt-1.1.43
	#	xmlto-0.0.29
	#	asciidoc-10.2.1 (to build additional documentation)

	# Note
	#	There is a reciprocal dependency with fop-2.11. If you wish to build the documentation,
	#	you'll need to re-install the Protocol Headers after the installation is complete and
	#	fop-2.11 has been installed.
	#	Editor Notes: https://wiki.linuxfromscratch.org/blfs/wiki/Xorg7ProtocolHeaders

main () {

	# Download (HTTP): https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz
	# Download MD5 sum: 12374d29fb5ae642cfa872035e401640
	# Download size: 744 KB
	# Estimated disk space required: 8.4 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 3 Support Applications"

	echoL "Downloading xorgproto (2024.1)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz xorgproto-2024.1.tar.xz
	cp ../Packages/xorgproto-2024.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xorgproto (2024.1)..."
	sleep 2
	cd /sources
	rm -fR xorgproto-2024.1
	tar -vxsf xorgproto-2024.1.tar.xz
	cd xorgproto-2024.1

	echoL "Building xorgproto (2024.1)..."
	sleep 2
	mkdir build &&
	cd    build &&
	meson setup --prefix=$XORG_PREFIX .. &&
	ninja

	echoL "Installing xorgproto (2024.1)..."
	sleep 2
	ninja install
	mv -v $XORG_PREFIX/share/doc/xorgproto{,-2024.1}

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xorgproto-2024.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
