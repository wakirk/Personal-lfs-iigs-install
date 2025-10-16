#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	# Zlib (1.3.1) - 1,478 KB:
	# Home page: https://zlib.net/
	# Download: https://zlib.net/fossils/zlib-1.3.1.tar.gz
	# MD5 sum: 9855b6d802d7fe5b7bd5b196a2271655

	echoL "Downloading Zlib (1.3.1)..."
	echoR "System Software"

	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://zlib.net/fossils/zlib-1.3.1.tar.gz zlib-1.3.1.tar.gz
	cp ../Packages/zlib-1.3.1.tar.gz /sources

	echoL "Unpack Zlib (1.3.1)..."
	sleep 2
	cd /sources
	rm -fR zlib-1.3.1
	tar -vxsf zlib-1.3.1.tar.gz
	cd zlib-1.3.1

	echoL "Building Zlib (1.3.1)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Installing Zlib (1.3.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR zlib-1.3.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
