#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# Recommended
#	Xorg Libraries (for Intel KMS API support required by Mesa)

# Optional
#	Cairo-1.18.4 (for tests)
#	CMake-4.1.0 (could be used to find dependencies without pkgconfig files)
#	docbook-xml-4.5
#	docbook-xsl-nons-1.79.2
#	docutils-0.21.2
#	libxslt-1.1.43 (to build manual pages)
#	libatomic_ops-7.8.2 (required by architectures without native atomic operations)
#	Valgrind-3.25.1
#	CUnit (for AMDGPU tests)

main () {


	# Download (HTTP): https://dri.freedesktop.org/libdrm/libdrm-2.4.125.tar.xz
	# Download MD5 sum: 3baec8e685510892b3355a7074baa874
	# Download size: 476 KB
	# Estimated disk space required: 12 MB (with tests)
	# Estimated build time: 0.1 SBU (with tests)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Libdrm (2.4.125)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://dri.freedesktop.org/libdrm/libdrm-2.4.125.tar.xz libdrm-2.4.125.tar.xz
	cp ../Packages/libdrm-2.4.125.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Libdrm (2.4.125)..."
	sleep 2
	cd /sources
	rm -fR libdrm-2.4.125
	tar -vxsf libdrm-2.4.125.tar.xz
	cd libdrm-2.4.125

	echoL "Building Libdrm (2.4.125)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=$XORG_PREFIX --buildtype=release -D udev=true \
		-D valgrind=disabled ..
	ninja

	echoL "Testing Libdrm (2.4.125)..."
	sleep 2
	ninja test

	echoL "Installing Libdrm (2.4.125)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libdrm-2.4.125

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
