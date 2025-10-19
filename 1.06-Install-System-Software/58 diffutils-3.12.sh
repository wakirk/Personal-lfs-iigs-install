#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Diffutils (3.12) - 1,894 KB:
	# Home page: https://www.gnu.org/software/diffutils/
	# Download: https://ftp.gnu.org/gnu/diffutils/diffutils-3.12.tar.xz
	# MD5 sum: d1b18b20868fb561f77861cd90b05de4
	echoR "System Software"

	echoL "Downloading Diffutils (3.12)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/diffutils/diffutils-3.12.tar.xz diffutils-3.12.tar.xz
	cp ../Packages/diffutils-3.12.tar.xz /sources

	echoL "Unpack Diffutils (3.12)..."
	sleep 2
	cd /sources
	rm -fR diffutils-3.12
	tar -vxsf diffutils-3.12.tar.xz
	cd diffutils-3.12

	echoL "Building Diffutils (3.12)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Testing Diffutils (3.12)..."
	sleep 2
	make check

	echoL "Installing Diffutils (3.12)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR diffutils-3.12

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
