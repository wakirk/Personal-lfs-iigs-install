#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Patch (2.8) - 886 KB:
	# Home page: https://savannah.gnu.org/projects/patch/
	# Download: https://ftp.gnu.org/gnu/patch/patch-2.8.tar.xz
	# MD5 sum: 149327a021d41c8f88d034eab41c039f
	echoR "System Software"

	echoL "Downloading Patch (2.8)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/patch/patch-2.8.tar.xz patch-2.8.tar.xz
	cp ../Packages/patch-2.8.tar.xz /sources

	echoL "Unpack Patch (2.8)..."
	sleep 2
	cd /sources
	rm -fR patch-2.8
	tar -vxsf patch-2.8.tar.xz
	cd patch-2.8

	echoL "Building Patch (2.8)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Testing Patch (2.8)..."
	sleep 2
	make check

	echoL "Installing Patch (2.8)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR patch-2.8

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
