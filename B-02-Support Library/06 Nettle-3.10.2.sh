#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Nettle Dependencies
	# 	Optional
	# 	Valgrind-3.25.1 (optional for the tests)

main () {

	# Download (HTTP): https://ftp.gnu.org/gnu/nettle/nettle-3.10.2.tar.gz
	# Download MD5 sum: b28bcbf6f045ff007940a9401673600d
	# Download size: 2.5 MB
	# Estimated disk space required: 102 MB (with tests)
	# Estimated build time: 0.2 SBU (with tests; both using parallelism=4)
	echoR "Group 2 Support Library"

	echoL "Downloading Nettle (3.10.2)..."
	sleep 2
	cd "/root/lfs/B-02-Support Library"
	../bash/Download.sh https://ftp.gnu.org/gnu/nettle/nettle-3.10.2.tar.gz nettle-3.10.2.tar.gz
	cp ../Packages/nettle-3.10.2.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Nettle (3.10.2)..."
	sleep 2
	cd /sources
	rm -fR nettle-3.10.2
	tar -vxsf nettle-3.10.2.tar.gz
	cd nettle-3.10.2

	echoL "Building Nettle (3.10.2)..."
	sleep 2
	./configure --prefix=/usr --disable-static &&
	make

	echoL "Testing Nettle (3.10.2)..."
	sleep 2
	make check

	echoL "Installing Nettle (3.10.2)..."
	sleep 2
	make install
	chmod   -v   755 /usr/lib/lib{hogweed,nettle}.so
	install -v -m755 -d /usr/share/doc/nettle-3.10.2
	install -v -m644 nettle.{html,pdf} /usr/share/doc/nettle-3.10.2

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR nettle-3.10.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
