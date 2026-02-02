#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/v20.1.5/SPIRV-LLVM-Translator-20.1.5.tar.gz
	# Download MD5 sum: 510a7cceed8205e4c3877f23d9c0911a
	# Download size: 1.7 MB
	# Estimated disk space required: 39 MB
	# Estimated build time: 0.4 SBU (with parallelism=4)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading SPIRV-LLVM-Translator (20.1.5)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/v20.1.5/SPIRV-LLVM-Translator-20.1.5.tar.gz SPIRV-LLVM-Translator-20.1.5.tar.gz
	cp ../Packages/SPIRV-LLVM-Translator-20.1.5.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack SPIRV-LLVM-Translator (20.1.5)..."
	sleep 2
	cd /sources
	rm -fR SPIRV-LLVM-Translator-20.1.5
	tar -vxsf SPIRV-LLVM-Translator-20.1.5.tar.gz
	cd SPIRV-LLVM-Translator-20.1.5

	echoL "Building SPIRV-LLVM-Translator (20.1.5)..."
	sleep 2
	mkdir build
	cd    build
	cmake -D CMAKE_INSTALL_PREFIX=/usr                   \
		  -D CMAKE_BUILD_TYPE=Release                    \
		  -D BUILD_SHARED_LIBS=ON                        \
		  -D CMAKE_SKIP_INSTALL_RPATH=ON                 \
		  -D LLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=/usr \
		  -G Ninja ..
	ninja

	echoL "Installing SPIRV-LLVM-Translator (20.1.5)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR SPIRV-LLVM-Translator-20.1.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
