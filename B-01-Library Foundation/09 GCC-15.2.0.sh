#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# GCC Dependencies
	# Optional
	# x	GDB-16.3
	# x	Graphviz-13.1.2 (some tests use it if installed; note that if it's installed but not built with libpng-1.6.50 these tests will fail)
	# o	Valgrind-3.25.1 (for tests)
	# x	ISL (to enable graphite optimization)

main () {

	# 09 GCC-15.2.0.sh
	# Package Information
	# Download (HTTP): https://ftp.gnu.org/gnu/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz
	# Download MD5 sum: b861b092bf1af683c46a8aa2e689a6fd
	# Download size: 96 MB
	# Estimated disk space required: 12 GB (3.8 GB installed with all listed languages; add 2 GB for tests)
	# Estimated build time: 16 SBU (add 33 SBU for tests; both with parallelism=8)
	echoR "Group 1 Library Foundation"

	echoL "Downloading GCC (15.2.0)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://ftp.gnu.org/gnu/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz gcc-15.2.0.tar.xz
	cp ../Packages/gcc-15.2.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack GCC (15.2.0)..."
	sleep 2
	cd /sources
	rm -fR gcc-15.2.0
	tar -vxsf gcc-15.2.0.tar.xz
	cd gcc-15.2.0

	echoL "Building GCC (15.2.0)..."
	sleep 2
	case $(uname -m) in
		x86_64)
		sed -i.orig '/m64=/s/lib64/lib/' gcc/config/i386/t-linux64
	;;
	esac
	mkdir build
	cd    build
	../configure              \
		--prefix=/usr         \
		--disable-multilib    \
		--with-system-zlib    \
		--enable-default-pie  \
		--enable-default-ssp  \
		--enable-host-pie     \
		--disable-fixincludes \
		--enable-languages=c,c++,fortran,go,objc,obj-c++,m2 &&
	make
	# /bin/bash

	# The tests are very long, and the results may be hard to find in the logs,
	# specially if you use parallel jobs with make. You can get a summary of the tests with:
	# echoL "Testing GCC (15.2.0)..."
	# make -k check
	# ../contrib/test_summary
	# /bin/bash

	echoL "Installing GCC (15.2.0)..."
	sleep 2
	make install &&
	mkdir -pv /usr/share/gdb/auto-load/usr/lib                                &&
	mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib                   &&
	chown -v -R root:root /usr/lib/gcc/*linux-gnu/15.2.0/include{,-fixed}     &&
	ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/15.2.0/liblto_plugin.so /usr/lib/bfd-plugins/

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gcc-15.2.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
