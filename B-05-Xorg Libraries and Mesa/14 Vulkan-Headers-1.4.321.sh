#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	CMake-4.1.0

main () {

	# Download (HTTP): https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.4.321/Vulkan-Headers-1.4.321.tar.gz
	# Download MD5 sum: 0121ba99047bf40ab93737209c7a170a
	# Download size: 2.6 MB
	# Estimated disk space required: 33 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Vulkan-Headers (1.4.321)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.4.321/Vulkan-Headers-1.4.321.tar.gz Vulkan-Headers-1.4.321.tar.gz
	cp ../Packages/Vulkan-Headers-1.4.321.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Vulkan-Headers (1.4.321)..."
	sleep 2
	cd /sources
	rm -fR Vulkan-Headers-1.4.321
	tar -vxsf Vulkan-Headers-1.4.321.tar.gz
	cd Vulkan-Headers-1.4.321

	echoL "Building Vulkan-Headers (1.4.321)..."
	sleep 2
	mkdir build
	cd    build
	cmake -D CMAKE_INSTALL_PREFIX=/usr -G Ninja ..
	ninja

	echoL "Testing Vulkan-Headers (1.4.321)..."
	sleep 2
	ninja test

	echoL "Installing Vulkan-Headers (1.4.321)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR Vulkan-Headers-1.4.321

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
