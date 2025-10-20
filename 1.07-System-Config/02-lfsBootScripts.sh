LFS-Bootscripts (20250827) - 34 KB:
Download: https://www.linuxfromscratch.org/lfs/downloads/12.4/lfs-bootscripts-20250827.tar.xz
MD5 sum: 3f661c64c2dfb55025767ed56074d059


#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	# Man-pages (6.15) - 1,817 KB:
	# Home page: https://www.kernel.org/doc/man-pages/
	# Download: https://www.kernel.org/pub/linux/docs/man-pages/man-pages-6.15.tar.xz
	# MD5 sum: 16f68d70139dd2bbcae4102be4705753

	echoL "Downloading Man-DB (2.13.1)..."
	echoR "System Software"
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	printf '%s\n' 'nameserver 1.1.1.1' 'nameserver 8.8.8.8' > /etc/resolv.conf
	../bash/Download.sh https://www.kernel.org/pub/linux/docs/man-pages/man-pages-6.15.tar.xz man-pages-6.15.tar.xz
	cp ../Packages/man-pages-6.15.tar.xz /sources
	
	echoL "Unpack: Man-DB (2.13.1)..."
	sleep 2
	cd /sources
	rm -fR man-pages-6.15
	tar -vxsf man-pages-6.15.tar.xz
	cd  man-pages-6.15

	echoL "Installing Man-DB (2.13.1)..."
	sleep 2
	rm -vrf /usr/share/{info,man,doc}/*
	find /usr/{lib,libexec} -name \*.la -delete
	rm -vrf /tools
	rm -v man3/crypt*
	make -R GIT=false prefix=/usr install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR man-pages-6.15

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
