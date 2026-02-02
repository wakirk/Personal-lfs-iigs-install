	#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	CMake-4.1.0

	# Optional
	#	Doxygen-1.14.0
	#	git-2.50.1
	#	Graphviz-13.1.2
	#	libunwind-1.8.2
	#	libxml2-2.14.5
	#	psutil-7.0.0 (for tests)
	#	Pygments-2.19.2
	#	PyYAML-6.0.2 (for tests)
	#	rsync-3.4.1 (for tests)
	#	sphinx-8.2.3
	#	texlive-20250308 (or install-tl-unx)
	#	Valgrind-3.25.1
	#	Zip-3.0
	#	myst-parser (for building documentation)
	#	OCaml
	#	Z3

main () {

	# Download (HTTP): https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/llvm-20.1.8.src.tar.xz
	# Download MD5 sum: 78040509eb91309b4ec2edfe12cd20d8
	# Download size: 70 MB
	# Estimated disk space required: 4.7 GB (1.1 GB installed; add 23 GB for tests and 2.3 GB for documentation)
	# Estimated build time: 13 SBU (Add 19 SBU for tests; both using parallelism=8)

	# Additional Downloads
	# Cmake modules for LLVM
	# Download: https://anduin.linuxfromscratch.org/BLFS/llvm/llvm-cmake-20.1.8.src.tar.xz
	# Download MD5 sum: 5bfb8f4b4a2b3ccffca0d2406e4cdcc6
	# Download size: 8.5 KB

	# Third-party dependencies for LLVM build system
	# Download: https://anduin.linuxfromscratch.org/BLFS/llvm/llvm-third-party-20.1.8.src.tar.xz
	# Download MD5 sum: 2ffd8624b3cbddf55a4e74a7d8ea89fa
	# Download size: 444 KB

	# Recommended Download Clang
	# Download: https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/clang-20.1.8.src.tar.xz
	# Download MD5 sum: 62a0500bb932868061607cde0c01f584
	# Download size: 23 MB

	# Optional Download  Compiler RT
	# Download: https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/compiler-rt-20.1.8.src.tar.xz
	# Download MD5 sum: 3869861662d173ca8303b9f1524d1e91
	# Download size: 2.5 MB
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading LLVM (20.1.8)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/llvm-20.1.8.src.tar.xz llvm-20.1.8.src.tar.xz
	cp ../Packages/llvm-20.1.8.src.tar.xz /sources

	../bash/Download.sh https://anduin.linuxfromscratch.org/BLFS/llvm/llvm-cmake-20.1.8.src.tar.xz llvm-cmake-20.1.8.src.tar.xz
	cp ../Packages/llvm-cmake-20.1.8.src.tar.xz /sources

	../bash/Download.sh https://anduin.linuxfromscratch.org/BLFS/llvm/llvm-third-party-20.1.8.src.tar.xz llvm-third-party-20.1.8.src.tar.xz
	cp ../Packages/llvm-third-party-20.1.8.src.tar.xz /sources

	../bash/Download.sh https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/clang-20.1.8.src.tar.xz clang-20.1.8.src.tar.xz
	cp ../Packages/clang-20.1.8.src.tar.xz /sources

	../bash/Download.sh https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/compiler-rt-20.1.8.src.tar.xz compiler-rt-20.1.8.src.tar.xz
	cp ../Packages/compiler-rt-20.1.8.src.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack LLVM (20.1.8)..."
	sleep 2
	cd /sources
	rm -fR llvm-20.1.8.src
	tar -vxsf llvm-20.1.8.src.tar.xz
	cd llvm-20.1.8.src

	echoL "Preparing LLVM (20.1.8)..."
	sleep 2
	tar -vxf ../llvm-cmake-20.1.8.src.tar.xz                              &&
	tar -vxf ../llvm-third-party-20.1.8.src.tar.xz                        &&
	sed '/LLVM_COMMON_CMAKE_UTILS/s@../cmake@cmake-20.1.8.src@'          \
		-i CMakeLists.txt                                                &&
	sed '/LLVM_THIRD_PARTY_DIR/s@../third-party@third-party-20.1.8.src@' \
		-i cmake/modules/HandleLLVMOptions.cmake

	tar -vxf ../clang-20.1.8.src.tar.xz -C tools &&
	mv -v tools/clang-20.1.8.src tools/clang

	tar -vxf ../compiler-rt-20.1.8.src.tar.xz -C projects    &&
	mv -v projects/compiler-rt-20.1.8.src projects/compiler-rt

	grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'

	sed 's/utility/tool/' -i utils/FileCheck/CMakeLists.txt
#	read

	echoL "Building LLVM (20.1.8)..."
	sleep 2
	mkdir -v build &&
	cd       build &&
	CC=gcc CXX=g++                             \
	cmake                                      \
		-D CMAKE_INSTALL_PREFIX=/usr           \
		-D CMAKE_SKIP_INSTALL_RPATH=ON         \
		-D LLVM_ENABLE_FFI=ON                  \
		-D CMAKE_BUILD_TYPE=Release            \
		-D LLVM_BUILD_LLVM_DYLIB=ON            \
		-D LLVM_LINK_LLVM_DYLIB=ON             \
		-D LLVM_ENABLE_RTTI=ON                 \
		-D LLVM_TARGETS_TO_BUILD="host;AMDGPU" \
		-D LLVM_BINUTILS_INCDIR=/usr/include   \
		-D LLVM_INCLUDE_BENCHMARKS=OFF         \
		-D CLANG_DEFAULT_PIE_ON_LINUX=ON       \
		-D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang \
		-W no-dev -G Ninja ..                  &&
	ninja
#	read

	sed -e 's/config.has_no_default_config_flag/True/' \
		-e 's/"-fuse-ld=gold"//'                       \
		-i ../projects/compiler-rt/test/lit.common.cfg.py

#	echoL "Testing LLVM (20.1.8)..."
#	sleep 2
#	sh -c 'ulimit -c 0 && ninja check-all'
#	read

	echoL "Installing LLVM (20.1.8)..."
	sleep 2
	ninja install
#	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR llvm-20.1.8.src

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
