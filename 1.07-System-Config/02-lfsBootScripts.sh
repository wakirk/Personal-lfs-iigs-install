#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	# LFS-Bootscripts (20250827) - 34 KB:
	# Download: https://www.linuxfromscratch.org/lfs/downloads/12.4/lfs-bootscripts-20250827.tar.xz
	# MD5 sum: 3f661c64c2dfb55025767ed56074d059

	echoL "Downloading LFS-Bootscripts (20250827)..."
	echoR "System Software"
	sleep 2
	cd "/root/lfs/1.07-System-Config"
	../bash/Download.sh https://www.linuxfromscratch.org/lfs/downloads/12.4/lfs-bootscripts-20250827.tar.xz lfs-bootscripts-20250827.tar.xz
	cp ../Packages/lfs-bootscripts-20250827.tar.xz /sources
	
	echoL "Unpack: LFS-Bootscripts (20250827)..."
	sleep 2
	cd /sources
	rm -fR lfs-bootscripts-20250827
	tar -vxsf lfs-bootscripts-20250827.tar.xz
	cd  lfs-bootscripts-20250827

	echoL "Installing LFS-Bootscripts (20250827)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR lfs-bootscripts-20250827
	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
