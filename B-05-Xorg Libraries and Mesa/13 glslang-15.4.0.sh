#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	#Required
	#	CMake-4.1.0
	#	SPIRV-Tools-1.4.321.0

main () {

	# Download (HTTP): https://github.com/KhronosGroup/glslang/archive/15.4.0/glslang-15.4.0.tar.gz
	# Download MD5 sum: a400ed377dc9de8b87a8179a90cef3b8
	# Download size: 4.0 MB
	# Estimated disk space required: 177 MB (with tests)
	# Estimated build time: 0.4 SBU (with parallelism=4; with tests)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading glslang (15.4.0)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/KhronosGroup/glslang/archive/15.4.0/glslang-15.4.0.tar.gz glslang-15.4.0.tar.gz
	cp ../Packages/glslang-15.4.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack glslang (15.4.0)..."
	sleep 2
	cd /sources
	rm -fR glslang-15.4.0
	tar -vxsf glslang-15.4.0.tar.gz
	cd glslang-15.4.0

	echoL "Building glslang (15.4.0)..."
	sleep 2
	mkdir build
	cd    build
	cmake -D CMAKE_INSTALL_PREFIX=/usr     \
		  -D CMAKE_BUILD_TYPE=Release      \
		  -D ALLOW_EXTERNAL_SPIRV_TOOLS=ON \
		  -D BUILD_SHARED_LIBS=ON          \
		  -D GLSLANG_TESTS=ON              \
		  -G Ninja .. &&
	ninja

	echoL "Testing glslang (15.4.0)..."
	sleep 2
	ninja test

	echoL "Installing glslang (15.4.0)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR glslang-15.4.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
