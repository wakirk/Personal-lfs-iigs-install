#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Package Information
	# Download (HTTP): https://dist.libuv.org/dist/v1.51.0/libuv-v1.51.0.tar.gz
	# Download MD5 sum: 5e0109e19c3fed3a8cbecb958de39afa
	# Download size: 1.3 MB
	# Estimated disk space required: 31 MB (with tests and man page)
	# Estimated build time: 0.5 SBU (with tests and man page)

	# libuv Dependencies
	# Optional
	# 	sphinx-8.2.3
	echoR "Group 1 Library Foundation"

	echoL "Downloading libuv (1.51.0)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://dist.libuv.org/dist/v1.51.0/libuv-v1.51.0.tar.gz libuv-v1.51.0.tar.gz
	cp ../Packages/libuv-v1.51.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libuv (1.51.0)..."
	sleep 2
	cd /sources
	rm -fR libuv-v1.51.0
	tar -vxsf libuv-v1.51.0.tar.gz
	cd libuv-v1.51.0

	echoL "Building libuv (1.51.0)..."
	sleep 2
	sh autogen.sh
	./configure --prefix=/usr --disable-static
	make 

	echoL "Installing libuv (1.51.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libuv-v1.51.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
