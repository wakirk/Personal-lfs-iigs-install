#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# libtasn1 Dependencies
# 	Optional
# 	GTK-Doc-1.34.0 and Valgrind-3.25.1

main () {

	# Package Information
	# Download (HTTP): https://ftp.gnu.org/gnu/libtasn1/libtasn1-4.20.0.tar.gz
	# Download MD5 sum: 930f71d788cf37505a0327c1b84741be
	# Download size: 1.7 MB
	# Estimated disk space required: 16 MB (with tests)
	# Estimated build time: 0.3 SBU (with tests)
	echoR "Group 1 Library Foundation"

	echoL "Downloading libtasn1 (4.20.0)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://ftp.gnu.org/gnu/libtasn1/libtasn1-4.20.0.tar.gz libtasn1-4.20.0.tar.gz
	cp ../Packages/libtasn1-4.20.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libtasn1 (4.20.0)..."
	sleep 2
	cd /sources
	rm -fR libtasn1-4.20.0
	tar -vxsf libtasn1-4.20.0.tar.gz
	cd libtasn1-4.20.0

	echoL "Building libtasn1 (4.20.0)..."
	sleep 2
	./configure --prefix=/usr --disable-static &&
	make

	echoL "Testing libtasn1 (4.20.0)..."
	make check

	echoL "Installing libtasn1 (4.20.0)..."
	sleep 2
	make install
	make -C doc/reference install-data-local

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libtasn1-4.20.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
