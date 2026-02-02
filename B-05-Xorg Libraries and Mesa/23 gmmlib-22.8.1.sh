#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	CMake-4.1.0

main () {

	# Download (HTTP): https://github.com/lfs-book/gmmlib/archive/v22.8.1/gmmlib-22.8.1.tar.gz
	# Download MD5 sum: 23869643d5e37c73854bd76964a124d8
	# Download size: 852 KB
	# Estimated disk space required: 58 MB
	# Estimated build time: 0.6 SBU
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading gmmlib (22.8.1)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/lfs-book/gmmlib/archive/v22.8.1/gmmlib-22.8.1.tar.gz gmmlib-22.8.1.tar.gz
	cp ../Packages/gmmlib-22.8.1.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack gmmlib (22.8.1)..."
	sleep 2
	cd /sources
	rm -fR gmmlib-22.8.1
	tar -vxsf gmmlib-22.8.1.tar.gz
	cd gmmlib-22.8.1

	echoL "Building gmmlib (22.8.1)..."
	sleep 2
	mkdir build
	cd    build
	cmake -D CMAKE_INSTALL_PREFIX=/usr \
		  -D BUILD_TYPE=Release        \
		  -G Ninja                     \
		  -W no-dev ..
	ninja

	echoL "Installing gmmlib (22.8.1)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gmmlib-22.8.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
