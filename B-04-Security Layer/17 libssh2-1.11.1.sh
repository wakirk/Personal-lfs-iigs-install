#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# libssh2 Dependencies
	# Optional
	#	CMake-4.1.0 (can be used instead of the configure script),
	#	libgcrypt-1.11.2 (can be used instead of OpenSSL)
	#	OpenSSH-10.0p1 (for some tests)
	#	and Docker (for some tests)

main () {

	# Download (HTTP): https://www.libssh2.org/download/libssh2-1.11.1.tar.gz
	# Download MD5 sum: 38857d10b5c5deb198d6989dacace2e6
	# Download size: 1.0 MB
	# Estimated disk space required: 15 MB (with tests)
	# Estimated build time: 0.2 SBU (with tests)
	echoR "Group 4 Security Layer"

	echoL "Downloading libssh2 (1.11.1)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://www.libssh2.org/download/libssh2-1.11.1.tar.gz libssh2-1.11.1.tar.gz
	cp ../Packages/libssh2-1.11.1.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libssh2 (1.11.1)..."
	sleep 2
	cd /sources
	rm -fR libssh2-1.11.1
	tar -vxsf libssh2-1.11.1.tar.gz
	cd libssh2-1.11.1

	echoL "Building libssh2 (1.11.1)..."
	sleep 2
	./configure --prefix=/usr          \
				--disable-docker-tests \
				--disable-static       &&
	make

	echoL "Testing libssh2 (1.11.1)..."
	sleep 2
	make check

	echoL "Installing libssh2 (1.11.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libssh2-1.11.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
