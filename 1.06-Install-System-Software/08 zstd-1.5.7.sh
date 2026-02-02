#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Zstd (1.5.7) - 2,378 KB:
	# Home page: https://facebook.github.io/zstd/
	# Download: https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz
	# MD5 sum: 780fc1896922b1bc52a4e90980cdda48
	echoR "System Software"

	echoL "Downloading Zstd (1.5.7)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz zstd-1.5.7.tar.gz
	cp ../Packages/zstd-1.5.7.tar.gz /sources

	echoL "Unpack Zstd (1.5.7)..."
	sleep 2
	cd /sources
	rm -fR zstd-1.5.7
	tar -vxsf zstd-1.5.7.tar.gz
	cd zstd-1.5.7

	echoL "Building Zstd (1.5.7)..."
	sleep 2
	make prefix=/usr
	make check

	echoL "Installing Zstd (1.5.7)..."
	sleep 2
	make prefix=/usr install
	rm -v /usr/lib/libzstd.a

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR zstd-1.5.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
