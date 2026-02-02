#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	Xorg build environment
	#	libdrm-2.4.125

	# Recommended
	#	Mesa-25.1.8

	# Recommended (Runtime)
	#	The VA API driver suitable for the hardware in your system:
	#		intel-vaapi-driver-2.4.1 (for Intel GPUs provided with Haswell CPUs or earlier),
	#		intel-media-driver-25.2.6 (for Intel GPUs provided with Broadwell CPUs or later),
	#		and Mesa-25.1.8 (providing the r600, radeonsi, and nouveau VA API drivers,
	#		for the ATI/AMD Radeon HD 2xxx GPUs and later,
	#		and supported NVIDIA GPUs; there is a circular dependency,
	#			read the Mesa page for information on how to break it)

	# Optional
	#	Doxygen-1.14.0
	#	Wayland-1.24.0
	#	and intel-gpu-tools

main () {

	# Download (HTTP): https://github.com/intel/libva/archive/2.22.0/libva-2.22.0.tar.gz
	# Download MD5 sum: 8dba13313d724b5e930f06e65b7437e2
	# Download size: 296 KB
	# Estimated disk space required: 3.7 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading libva (2.22.0)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/intel/libva/archive/2.22.0/libva-2.22.0.tar.gz libva-2.22.0.tar.gz
	cp ../Packages/libva-2.22.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libva (2.22.0)..."
	sleep 2
	cd /sources
	rm -fR libva-2.22.0
	tar -vxsf libva-2.22.0.tar.gz
	cd libva-2.22.0

	echoL "Building libva (2.22.0)..."
	sleep 2
	cd build
	meson setup --prefix=$XORG_PREFIX --buildtype=release
	ninja

	echoL "Installing libva (2.22.0)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libva-2.22.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
