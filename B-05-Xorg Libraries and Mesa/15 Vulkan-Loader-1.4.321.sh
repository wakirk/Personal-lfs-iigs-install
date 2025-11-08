#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	CMake-4.1.0
	#	Vulkan-Headers-1.4.321
	#	Xorg Libraries

	# Recommended
	#	Wayland-1.24.0

	# Recommended (Runtime)
	#	Mesa-25.1.8 (for Vulkan drivers)

	# Optional (for testing)
	#	git-2.50.1

main () {

	# Download (HTTP): https://github.com/KhronosGroup/Vulkan-Loader/archive/v1.4.321/Vulkan-Loader-1.4.321.tar.gz
	# Download MD5 sum: 880cb5b96b4f94282db03337dcb8743d
	# Download size: 1.7 MB
	# Estimated disk space required: 11 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Vulkan-Loader (1.4.321)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/KhronosGroup/Vulkan-Loader/archive/v1.4.321/Vulkan-Loader-1.4.321.tar.gz Vulkan-Loader-1.4.321.tar.gz
	cp ../Packages/Vulkan-Loader-1.4.321.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Vulkan-Loader (1.4.321)..."
	sleep 2
	cd /sources
	rm -fR Vulkan-Loader-1.4.321
	tar -vxsf Vulkan-Loader-1.4.321.tar.gz
	cd Vulkan-Loader-1.4.321

	echoL "Building Vulkan-Loader (1.4.321)..."
	sleep 2
	mkdir build
	cd    build
	cmake -D CMAKE_INSTALL_PREFIX=/usr     \
		  -D CMAKE_BUILD_TYPE=Release      \
		  -D CMAKE_SKIP_INSTALL_RPATH=ON   \
		  -D BUILD_WSI_WAYLAND_SUPPORT=OFF \
		  -G Ninja ..
	ninja

	echoL "Testing Vulkan-Loader (1.4.321)..."
	sleep 2
	sed "s/'git', 'clone'/&, '--depth=1', '-b', self.commit/" -i ../scripts/update_deps.py &&
	cmake -D BUILD_TESTS=ON -D UPDATE_DEPS=ON ..
	ninja
	ninja test

	echoL "Installing Vulkan-Loader (1.4.321)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR Vulkan-Loader-1.4.321

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
