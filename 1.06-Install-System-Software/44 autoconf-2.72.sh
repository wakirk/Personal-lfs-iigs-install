#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Autoconf (2.72) - 1,360 KB:
	# Home page: https://www.gnu.org/software/autoconf/
	# Download: https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz
	# MD5 sum: 1be79f7106ab6767f18391c5e22be701
	echoR "System Software"

	echoL "Downloading Autoconf (2.72)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz autoconf-2.72.tar.xz
	cp ../Packages/autoconf-2.72.tar.xz /sources

	echoL "Unpack Autoconf (2.72)..."
	sleep 2
	cd /sources
	rm -fR autoconf-2.72
	tar -vxsf autoconf-2.72.tar.xz
	cd autoconf-2.72

	echoL "Building Autoconf (2.72)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Testing Autoconf (2.72)..."
	sleep 2
	make check

	echoL "Installing Autoconf (2.72)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR autoconf-2.72

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
