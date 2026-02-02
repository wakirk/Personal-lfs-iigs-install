#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Libtool (2.5.4) - 1,033 KB:
	# Home page: https://www.gnu.org/software/libtool/
	# Download: https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz
	# MD5 sum: 22e0a29df8af5fdde276ea3a7d351d30
	echoR "System Software"

	echoL "Downloading Libtool (2.5.4)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz libtool-2.5.4.tar.xz
	cp ../Packages/libtool-2.5.4.tar.xz /sources

	echoL "Unpack Libtool (2.5.4)..."
	sleep 2
	cd /sources
	rm -fR libtool-2.5.4
	tar -vxsf libtool-2.5.4.tar.xz
	cd libtool-2.5.4

	echoL "Building Libtool (2.5.4)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Testing Libtool (2.5.4)..."
	sleep 2
	make check

	echoL "Installing Libtool (2.5.4)..."
	sleep 2
	make install
	rm -fv /usr/lib/libltdl.a

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libtool-2.5.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
