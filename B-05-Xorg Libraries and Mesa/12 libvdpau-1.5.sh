#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	Xorg Libraries

	# Recommended (Runtime)
	# The VDPAU driver suitable for the hardware in your system:
	#	libvdpau-va-gl-0.4.2 (for Intel GPUs) and Mesa-25.1.8 (providing the r600, radeonsi, and nouveau VDPAU drivers, for the ATI/AMD Radeon HD 2xxx GPUs and later, and supported NVIDIA GPUs; Mesa must be built after this package for these drivers)

	# Optional
	#	Doxygen-1.14.0
	#	Graphviz-13.1.2
	#	texlive-20250308 or install-tl-unx

main () {

	# Download (HTTP): https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/1.5/libvdpau-1.5.tar.bz2
	# Download MD5 sum: 148a192110e7a49d62c0bf9ef916c099
	# Download size: 140 KB
	# Estimated disk space required: 4.6 MB (with tests)
	# Estimated build time: less than 0.1 SBU (with tests)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading libvdpau (1.5)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/1.5/libvdpau-1.5.tar.bz2 libvdpau-1.5.tar.bz2
	cp ../Packages/libvdpau-1.5.tar.bz2 /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libvdpau (1.5)..."
	sleep 2
	cd /sources
	rm -fR libvdpau-1.5
	tar -vxsf libvdpau-1.5.tar.bz2
	cd libvdpau-1.5

	echoL "Building libvdpau (1.5)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=$XORG_PREFIX ..
	ninja

	echoL "Testing libvdpau (1.5)..."
	sleep 2
	ninja test

	echoL "Installing libvdpau (1.5)..."
	sleep 2
	ninja install
	# If doxygen is present at build time place the documentation in a versioned directory as the root user:
	# [ -e $XORG_PREFIX/share/doc/libvdpau ] && mv -v $XORG_PREFIX/share/doc/libvdpau{,1.5}

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libvdpau-1.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
