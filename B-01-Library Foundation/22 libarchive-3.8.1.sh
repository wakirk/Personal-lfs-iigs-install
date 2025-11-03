#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# libarchive Dependencies
# Optional
# 	libxml2-2.14.5, LZO-2.10, Nettle-3.10.2, and pcre2-10.45

main () {

	# Download (HTTP): https://github.com/libarchive/libarchive/releases/download/v3.8.1/libarchive-3.8.1.tar.xz
	# Download MD5 sum: 80fd1a7acc4da7c7d4a5f9f96df6e3ff
	# Download size: 5.7 MB
	# Estimated disk space required: 43 MB (add 32 MB for tests)
	# Estimated build time: 0.3 SBU (add 0.8 SBU for tests)
	echoR "Group 1 Library Foundation"

	echoL "Downloading libarchive (3.8.1)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://github.com/libarchive/libarchive/releases/download/v3.8.1/libarchive-3.8.1.tar.xz libarchive-3.8.1.tar.xz
	cp ../Packages/libarchive-3.8.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libarchive (3.8.1)..."
	sleep 2
	cd /sources
	rm -fR libarchive-3.8.1
	tar -vxsf libarchive-3.8.1.tar.xz
	cd libarchive-3.8.1

	echoL "Building libarchive (3.8.1)..."
	sleep 2
	./configure --prefix=/usr --disable-static
	make

	echoL "Installing libarchive (3.8.1)..."
	sleep 2
	make install
	ln -sfv bsdunzip /usr/bin/unzip

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libarchive-3.8.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
