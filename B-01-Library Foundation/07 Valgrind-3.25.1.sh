#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	#	Valgrind Dependencies
	#	Optional
	#	x	docbook-xml-4.5 (for tests)
	#	x	GDB-16.3 (for tests)
	#	x	libaio-0.3.113
	#	x	LLVM-20.1.8 (with Clang)
	#	o	Which-2.23 (for tests)
	#
	#	[Note] Note
	#	The OpenMP tests are skipped if libgomp has been compiled with --enable-linux-futex (the default).
	#	If needed, just recompile the libgomp library from the gcc build tree, 
	#	passing --disable-linux-futex to configure, storing the library to some place and changing
	#	the link from /usr/lib/libgomp.so.1 to point to the new library.

main () {
	# Package Information Valgrind (3.25.1)
	# Download (HTTP): https://sourceware.org/pub/valgrind/valgrind-3.25.1.tar.bz2
	# Download MD5 sum: 2b424c9a43aa9bf2840d4989b01ea6e7
	# Download size: 16 MB
	# Estimated disk space required: 419 MB (add 86 MB for tests)
	# Estimated build time: 0.4 SBU (add 5.7 SBU for tests; both using parallelism=4)
	echoR "Group 1 Library Foundation"

	echoL "Downloading Valgrind (3.25.1)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://sourceware.org/pub/valgrind/valgrind-3.25.1.tar.bz2 valgrind-3.25.1.tar.bz2
	cp ../Packages/valgrind-3.25.1.tar.bz2 /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Valgrind (3.25.1)..."
	sleep 2
	cd /sources
	rm -fR valgrind-3.25.1
	tar -vxsf valgrind-3.25.1.tar.bz2
	cd valgrind-3.25.1

	echoL "Building Valgrind (3.25.1)..."
	sleep 2
	sed -i 's|/doc/valgrind||' docs/Makefile.in
	./configure --prefix=/usr --datadir=/usr/share/doc/valgrind-3.25.1
	make

	echoL "Installing Valgrind (3.25.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR valgrind-3.25.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
