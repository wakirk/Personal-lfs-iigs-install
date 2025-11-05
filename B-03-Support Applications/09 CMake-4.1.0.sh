#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# CMake Dependencies
	#	Recommended
	#	cURL-8.15.0
	#	libarchive-3.8.1
	#	libuv-1.51.0
	#	nghttp2-1.66.0

	# Optional
	#	GCC-15.2.0 (for gfortran)
	#	git-2.50.1 (for use during tests)
	#	mercurial-7.1 (for use during tests)
	#	OpenJDK-24.0.2 (for use during tests)
	#	Qt-6.9.2 (for the Qt-based GUI)
	#	sphinx-8.2.3 (for building documents)
	#	Subversion-1.14.5 (for testing),
	#	cppdap
	#	jsoncpp
	#	rhash

main () {

	# Download (HTTP): https://cmake.org/files/v4.1/cmake-4.1.0.tar.gz
	# Download MD5 sum: 80ae27faba5068c8ec12c77bf00e6db3
	# Download size: 11 MB
	# Estimated disk space required: 621 MB (add 1.4 GB for tests)
	# Estimated build time: 2.6 SBU (add 4.3 SBU for tests, both using parallelism=4)
	echoR "Group 3 Support Applications"

	echoL "Downloading CMake (4.1.0)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://cmake.org/files/v4.1/cmake-4.1.0.tar.gz cmake-4.1.0.tar.gz
	cp ../Packages/cmake-4.1.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack CMake (4.1.0)..."
	sleep 2
	cd /sources
	rm -fR cmake-4.1.0
	tar -vxsf cmake-4.1.0.tar.gz
	cd cmake-4.1.0

	echoL "Building CMake (4.1.0)..."
	sleep 2
	sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake &&
	./bootstrap --prefix=/usr        \
				--system-libs        \
				--mandir=/share/man  \
				--no-system-jsoncpp  \
				--no-system-cppdap   \
				--no-system-librhash \
				--docdir=/share/doc/cmake-4.1.0 &&
	make

	echoL "Testing CMake (4.1.0)..."
	sleep 2
	bin/ctest -j$(nproc)

	echoL "Installing CMake (4.1.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR cmake-4.1.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
