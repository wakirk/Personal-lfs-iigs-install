#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Gzip (1.14) - 865 KB:
	# Home page: https://www.gnu.org/software/gzip/
	# Download: https://ftp.gnu.org/gnu/gzip/gzip-1.14.tar.xz
	# MD5 sum: 4bf5a10f287501ee8e8ebe00ef62b2c2
	echoR "System Software"

	echoL "Downloading Gzip (1.14)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/gzip/gzip-1.14.tar.xz gzip-1.14.tar.xz
	cp ../Packages/gzip-1.14.tar.xz /sources

	echoL "Unpack Gzip (1.14)..."
	sleep 2
	cd /sources
	rm -fR gzip-1.14
	tar -vxsf gzip-1.14.tar.xz
	cd gzip-1.14

	echoL "Building Gzip (1.14)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Testing Gzip (1.14)..."
	sleep 2
	make check

	echoL "Installing Gzip (1.14)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gzip-1.14

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
