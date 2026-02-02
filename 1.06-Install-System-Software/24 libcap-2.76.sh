#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Libcap (2.76) - 195 KB:
	# Home page: https://sites.google.com/site/fullycapable/
	# Download: https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.76.tar.xz
	# MD5 sum: 449ade7d620b5c4eeb15a632fbaa4f74
	echoR "System Software"

	echoL "Downloading Libcap (2.76)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.76.tar.xz libcap-2.76.tar.xz
	cp ../Packages/libcap-2.76.tar.xz /sources

	echoL "Unpack Libcap (2.76)..."
	sleep 2
	cd /sources
	rm -fR libcap-2.76
	tar -vxsf libcap-2.76.tar.xz
	cd libcap-2.76

	echoL "Building Libcap (2.76)..."
	sleep 2
	sed -i '/install -m.*STA/d' libcap/Makefile
	make prefix=/usr lib=lib

	echoL "Testing Libcap (2.76)..."
	sleep 2
	make test

	echoL "Installing Libcap (2.76)..."
	sleep 2
	make prefix=/usr lib=lib install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libcap-2.76

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
