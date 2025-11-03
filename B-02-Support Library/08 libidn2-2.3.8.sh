#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# libidn2 Dependencies
# Recommended
# 	libunistring-1.3

#Optional
#	git-2.50.1
#	GTK-Doc-1.34.0

main () {

	# Download (HTTP): https://ftp.gnu.org/gnu/libidn/libidn2-2.3.8.tar.gz
	# Download MD5 sum: a8e113e040d57a523684e141970eea7a
	# Download size: 2.1 MB
	# Estimated disk space required: 21 MB (add 3 MB for tests)
	# Estimated build time: 0.1 SBU (add 0.6 SBU for tests)
	echoR "Group 2 Support Library"

	echoL "Downloading libidn2 (2.3.8)..."
	sleep 2
	cd "/root/lfs/B-02-Support Library"

	../bash/Download.sh https://ftp.gnu.org/gnu/libidn/libidn2-2.3.8.tar.gz libidn2-2.3.8.tar.gz
	cp ../Packages/libidn2-2.3.8.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libidn2 (2.3.8)..."
	sleep 2
	cd /sources
	rm -fR libidn2-2.3.8
	tar -vxsf libidn2-2.3.8.tar.gz
	cd libidn2-2.3.8

	echoL "Building libidn2 (2.3.8)..."
	sleep 2
	./configure --prefix=/usr --disable-static
	make

	echoL "Testing libidn2 (2.3.8)..."
	sleep 2
	make check

	echoL "Installing libidn2 (2.3.8)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libidn2-2.3.8

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
