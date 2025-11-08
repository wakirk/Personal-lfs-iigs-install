#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	CMake-4.1.0
	#	gmmlib-22.8.1
	#	libva-2.22.0
	#	Xorg build environment

# Kernel Configuration
# Enable the following options in the kernel configuration. Recompile the kernel if necessary:

# Device Drivers --->
#   Graphics support --->
#     <*/M>   Direct Rendering Manager (XFree86 4.1.0 and higher DRI support) --->
#                                                                       ...  [DRM]
#     < /*/M> Intel 8xx/9xx/G3x/G4x/HD Graphics                         [DRM_I915]
#     < /*/M> Intel Xe2 Graphics                                          [DRM_XE]
#     (*)       Force probe xe for selected Intel hardware IDs
#                                                        ...  [DRM_XE_FORCE_PROBE]
# See Mesa Kernel Configuration for more info about the i915 driver and the Xe driver.

# Installation of intel-media-driver
# [Note] Note
# This package takes a long time to build because it compiles code specific to each individual
# generation of Intel GPUs and for a variety of media codecs.

# If you know the model of your Intel GPU, you can pass the -D{GEN{8,9,11,12},MTL,ARL,LNL,BMG,PTL}=OFF 
# option to the cmake command but leaving the option for your GPU out. Note that the “GEN”
# number here is the generation of the GPU, not the CPU. For example, with an Intel Core
# i7-1065G7 CPU shipping a 11th-generation Intel GPU, the -D{GEN{8,9,12},MTL,ARL,LNL,BMG,PTL}=OFF
# option can be used so the code specific to the other generations of Intel GPUs won't be built.

# To determine the model of the Intel GPU, install pciutils-3.14.0 and run 
# 	lspci -nn | grep -Ei 'VGA|DISPLAY'
# first. It will output some information about the GPU, including the P
# CI vendor ID (8086 for Intel) and the PCI device ID. For example, with an Intel Core
# i5-11300H CPU, the output is 8086:9a49. Now searching for the registration of this
# device ID in the intel-media-driver source tree:

# grep -ri 'RegisterDevice(0x3e9b'  8086:3e9b
# media_driver/linux/gen9/ddi/media_sysinfo_g9.cpp:    RegisterDevice(0x3e9b, &cflGt2Info);
# And determine the GPU model from the file name containing the registration.
# For the example above, the file name is media_sysinfo_g12.cpp, indicating the model is GEN12.

main () {

	# Download (HTTP): https://github.com/lfs-book/intel-media-driver/archive/v25.2.6/intel-media-driver-25.2.6.tar.gz
	# Download MD5 sum: 87fdb5bc73a6dc33cb6090dad5194f0c
	# Download size: 27 MB
	# Estimated disk space required: 2.0 GB (289 MB installed with a single GPU model)
	# Estimated build time: 3.2 SBU (with parallelism=4 and a single GPU model)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Intel Media Driver (25.2.6)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/lfs-book/intel-media-driver/archive/v25.2.6/intel-media-driver-25.2.6.tar.gz intel-media-driver-25.2.6.tar.gz
	cp ../Packages/intel-media-driver-25.2.6.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Intel Media Driver (25.2.6)..."
	sleep 2
	cd /sources
	rm -fR intel-media-driver-25.2.6
	tar -vxsf intel-media-driver-25.2.6.tar.gz
	cd intel-media-driver-25.2.6

	echoL "Building Intel Media Driver (25.2.6)..."
	sleep 2
	mkdir build
	cd    build
	# removed gen 9 so it will be built for the C64x
	cmake -D CMAKE_INSTALL_PREFIX=$XORG_PREFIX     \
		  -D CMAKE_POLICY_VERSION_MINIMUM=3.5      \
		  -D INSTALL_DRIVER_SYSCONF=OFF            \
		  -D BUILD_TYPE=Release                    \
		  -D MEDIA_BUILD_FATAL_WARNINGS=OFF        \
		  -D{GEN{8,11,12},MTL,ARL,LNL,BMG,PTL}=OFF \
		  -G Ninja                             \
		  -W no-dev ..
	ninja

	echoL "Installing Intel Media Driver (25.2.6)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR intel-media-driver-25.2.6

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
