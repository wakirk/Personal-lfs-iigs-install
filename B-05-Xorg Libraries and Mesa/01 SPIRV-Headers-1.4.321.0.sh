#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# SPIRV-Headers Dependencies
# Required
#	CMake-4.1.0

main () {

	# Download (HTTP): https://github.com/KhronosGroup/SPIRV-Headers/archive/vulkan-sdk-1.4.321.0/SPIRV-Headers-vulkan-sdk-1.4.321.0.tar.gz
	# Download MD5 sum: ef203788b47d207f7a71bdf4fa02d6f2
	# Download size: 528 KB
	# Estimated disk space required: 4.4 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 4 Security Layer"

	echoL "Downloading SPIRV-Headers (1.4.321.0)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/KhronosGroup/SPIRV-Headers/archive/vulkan-sdk-1.4.321.0/SPIRV-Headers-vulkan-sdk-1.4.321.0.tar.gz SPIRV-Headers-vulkan-sdk-1.4.321.0.tar.gz
	cp ../Packages/SPIRV-Headers-vulkan-sdk-1.4.321.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack SPIRV-Headers (1.4.321.0)..."
	sleep 2
	cd /sources
	rm -fR SPIRV-Headers-vulkan-sdk-1.4.321.0
	tar -vxsf SPIRV-Headers-vulkan-sdk-1.4.321.0.tar.gz
	cd SPIRV-Headers-vulkan-sdk-1.4.321.0

	echoL "Building SPIRV-Headers (1.4.321.0)..."
	sleep 2
	mkdir build &&
	cd    build &&
	cmake -D CMAKE_INSTALL_PREFIX=/usr -G Ninja ..
	ninja

	echoL "Installing SPIRV-Headers (1.4.321.0)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR SPIRV-Headers-vulkan-sdk-1.4.321.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
