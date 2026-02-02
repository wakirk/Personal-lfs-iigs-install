#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Automake (1.18.1) - 1,614 KB:
	# Home page: https://www.gnu.org/software/automake/
	# Download: https://ftp.gnu.org/gnu/automake/automake-1.18.1.tar.xz
	# MD5 sum: cea31dbf1120f890cbf2a3032cfb9a68
	echoR "System Software"

	echoL "Downloading Automake (1.18.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/automake/automake-1.18.1.tar.xz automake-1.18.1.tar.xz
	cp ../Packages/automake-1.18.1.tar.xz /sources

	echoL "Unpack Automake (1.18.1)..."
	sleep 2
	cd /sources
	rm -fR automake-1.18.1
	tar -vxsf automake-1.18.1.tar.xz
	cd automake-1.18.1

	echoL "Building Automake (1.18.1)..."
	sleep 2
	./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.18.1
	make

	echoL "Testing Automake (1.18.1)..."
	sleep 2
	# Using four parallel jobs speeds up the tests, even on systems with less logical cores, due to internal delays
	# in individual tests. To test the results, issue:
	make -j$(($(nproc)>4?$(nproc):4)) check
	# Replace $((...)) with the number of logical cores you want to use if you don't want to use all.

	echoL "Installing Automake (1.18.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR automake-1.18.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
