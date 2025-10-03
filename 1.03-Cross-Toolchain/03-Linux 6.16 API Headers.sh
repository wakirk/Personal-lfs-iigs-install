#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Linux (6.16.1) - 149,042 KB:
#Home page: https://www.kernel.org/
#Download: https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.16.1.tar.xz
#MD5 sum: 32d45755e4b39d06e9be58f6817445ee

main () {
	clear
	echoR "Installing Software"
	echoL "Downloading Linux Kernel (6.16)..."

	echo "Downloading Linux Kernel (6.16)..."
	/home/lfs/lfs/bash/download.sh https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.16.1.tar.xz linux-6.16.1.tar.xz
	cp -fv /home/lfs/lfs/Packages/linux-6.16.1.tar.xz $LFS/sources
	cd $LFS/sources

	echoL "Unpack: Linux Kernel (6.16)..."
	sleep 2
	rm -fR linux-6.16.1
	tar -vxsf linux-6.16.1.tar.xz
	cd linux-6.16.1

	echoL "Building Linux Kernel Headers (6.16)..."
	make mrproper
	make headers
	find usr/include -type f ! -name '*.h' -delete
	cp -rv usr/include $LFS/usr

#	echoL "Installing Linux Kernel (6.16)..."


	echoL "Install Linux Kernel (6.16)"
	sleep 2
	cd ..
	rm -fR linux-6.16.1

	exit 1
}


lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
