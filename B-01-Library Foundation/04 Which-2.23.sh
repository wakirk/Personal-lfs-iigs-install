#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Package Information
	# Download (HTTP): https://ftp.gnu.org/gnu/which/which-2.23.tar.gz
	# Download MD5 sum: 1963b85914132d78373f02a84cdb3c86
	# Download size: 197 KB
	# Estimated disk space required: 1.2 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 1 Library Foundation"

	echoL "Downloading Which (2.23)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://ftp.gnu.org/gnu/which/which-2.23.tar.gz which-2.23.tar.gz
	cp ../Packages/which-2.23.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Which (2.23)..."
	sleep 2
	cd /sources
	rm -fR which-2.23
	tar -vxsf which-2.23.tar.gz
	cd which-2.23

	echoL "Building Which (2.23)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Installing Which (2.23)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR which-2.23

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
