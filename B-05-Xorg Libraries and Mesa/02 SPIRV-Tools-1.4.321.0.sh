#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# SPIRV-Tools Dependencies
	# Required
	#	CMake-4.1.0
	#	SPIRV-Headers-1.4.321.0

main () {

	# Package Information
	# Download (HTTP): https://github.com/KhronosGroup/SPIRV-Tools/archive/vulkan-sdk-1.4.321.0/SPIRV-Tools-vulkan-sdk-1.4.321.0.tar.gz
	# Download MD5 sum: bd91a34dcbd8301cba5f4fa9524c7d9f
	# Download size: 3.2 MB
	# Estimated disk space required: 61 MB
	# Estimated build time: 0.6 SBU (with tests; both using parallelism=8)
	echoR "Group 4 Security Layer"

	echoL "Downloading SPIRV-Tools (1.4.321.0)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/KhronosGroup/SPIRV-Tools/archive/vulkan-sdk-1.4.321.0/SPIRV-Tools-vulkan-sdk-1.4.321.0.tar.gz SPIRV-Tools-vulkan-sdk-1.4.321.0.tar.gz
	cp ../Packages/SPIRV-Tools-vulkan-sdk-1.4.321.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack SPIRV-Tools (1.4.321.0)..."
	sleep 2
	cd /sources
	rm -fR SPIRV-Tools-vulkan-sdk-1.4.321.0
	tar -vxsf SPIRV-Tools-vulkan-sdk-1.4.321.0.tar.gz
	cd SPIRV-Tools-vulkan-sdk-1.4.321.0

	echoL "Building SPIRV-Tools (1.4.321.0)..."
	sleep 2
	mkdir build &&
	cd    build &&
	cmake -D CMAKE_INSTALL_PREFIX=/usr     \
		  -D CMAKE_BUILD_TYPE=Release      \
		  -D SPIRV_WERROR=OFF              \
		  -D BUILD_SHARED_LIBS=ON          \
		  -D SPIRV_TOOLS_BUILD_STATIC=OFF  \
		  -D SPIRV-Headers_SOURCE_DIR=/usr \
		  -G Ninja .. &&
	ninja

	echoL "Testing SPIRV-Tools (1.4.321.0)..."
	sleep 2
	ninja test

	echoL "Installing SPIRV-Tools (1.4.321.0)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR SPIRV-Tools-vulkan-sdk-1.4.321.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
