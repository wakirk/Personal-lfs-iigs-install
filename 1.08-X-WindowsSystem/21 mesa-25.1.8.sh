#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	# Package Information
	# Download (HTTP): https://mesa.freedesktop.org/archive/mesa-25.1.8.tar.xz
	# Download MD5 sum: fe3eb39e8a3c6fbb36eb3da57be022e7
	# Download size: 45 MB
	# Estimated disk space required: 1.1 GB (with docs; add 576 MB for tests)
	# Estimated build time: 3.8 SBU (with docs; add 1.7 SBU for tests; both with parallelism=4)
	echoR "System Software"

	echoL "Downloading Mesa (25.1.8)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://mesa.freedesktop.org/archive/mesa-25.1.8.tar.xz mesa-25.1.8.tar.xz
	cp ../Packages/mesa-25.1.8.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Mesa (25.1.8)..."
	sleep 2
	cd /sources
	rm -fR mesa-25.1.8
	tar -vxsf mesa-25.1.8.tar.xz
	cd mesa-25.1.8

	echoL "Building Mesa (25.1.8)..."
	sleep 2
	mkdir build
	cd    build
	meson setup ..              \
	--prefix=$XORG_PREFIX       \
	--buildtype=release         \
	-D platforms=x11            \
	-D glx=dri                  \
	-D glvnd=disabled           \
	-D gallium-drivers=softpipe \
	-D llvm=disabled            \
	-D vulkan-drivers=[]        \
	-D gallium-va=disabled      \
	-D gallium-vdpau=disabled
	ninja

	echoL "Installing Mesa (25.1.8)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR mesa-25.1.8

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
