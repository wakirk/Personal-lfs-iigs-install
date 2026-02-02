#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# File (5.46) - 1,283 KB:
	# Home page: https://www.darwinsys.com/file/
	# Download: https://astron.com/pub/file/file-5.46.tar.gz
	# MD5 sum: 459da2d4b534801e2e2861611d823864
	echoR "System Software"

	echoL "Downloading File (5.46)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://astron.com/pub/file/file-5.46.tar.gz file-5.46.tar.gz
	cp ../Packages/file-5.46.tar.gz /sources

	echoL "Unpack File (5.46)..."
	sleep 2
	cd /sources
	rm -fR file-5.46
	tar -vxsf file-5.46.tar.gz
	cd file-5.46

	echoL "Building File (5.46)..."
	sleep 2
	./configure --prefix=/usr
	make
	make check
	
	echoL "Installing File (5.46)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR file-5.46

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
