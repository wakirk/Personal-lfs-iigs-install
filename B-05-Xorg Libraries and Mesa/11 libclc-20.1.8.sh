#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	SPIRV-LLVM-Translator-20.1.5

main () {

	# Download (HTTP): https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/libclc-20.1.8.src.tar.xz
	# Download MD5 sum: b49b6b81298c9eb1609073b9164ff4cb
	# Download size: 134 KB
	# Estimated disk space required: 431 MB
	# Estimated build time: 0.6 SBU (with parallelism=8)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading libclc (20.1.8)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/libclc-20.1.8.src.tar.xz libclc-20.1.8.src.tar.xz
	cp ../Packages/libclc-20.1.8.src.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libclc (20.1.8)..."
	sleep 2
	cd /sources
	rm -fR libclc-20.1.8.src
	tar -vxsf libclc-20.1.8.src.tar.xz
	cd libclc-20.1.8.src

	echoL "Building libclc (20.1.8)..."
	sleep 2
	mkdir build
	cd    build
	cmake -D CMAKE_INSTALL_PREFIX=/usr \
		-D CMAKE_BUILD_TYPE=Release    \
		-G Ninja ..
	ninja

	echoL "Testing libclc (20.1.8)..."
	sleep 2
	ninja test

	echoL "Installing libclc (20.1.8)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libclc-20.1.8.src

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
