#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Libpipeline (1.5.8) - 1046 KB:
	# Home page: https://libpipeline.nongnu.org/
	# Download: https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.8.tar.gz
	# MD5 sum: 17ac6969b2015386bcb5d278a08a40b5
	echoR "System Software"

	echoL "Downloading Libpipeline (1.5.8)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.8.tar.gz libpipeline-1.5.8.tar.gz
	cp ../Packages/libpipeline-1.5.8.tar.gz /sources

	echoL "Unpack Libpipeline (1.5.8)..."
	sleep 2
	cd /sources
	rm -fR libpipeline-1.5.8
	tar -vxsf libpipeline-1.5.8.tar.gz
	cd libpipeline-1.5.8

	echoL "Building Libpipeline (1.5.8)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Installing Libpipeline (1.5.8)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libpipeline-1.5.8

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
