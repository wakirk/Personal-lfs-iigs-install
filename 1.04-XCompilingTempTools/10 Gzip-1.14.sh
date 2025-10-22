#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Gzip (1.14) - 865 KB:
#Home page: https://www.gnu.org/software/gzip/
#Download: https://ftp.gnu.org/gnu/gzip/gzip-1.14.tar.xz
#MD5 sum: 4bf5a10f287501ee8e8ebe00ef62b2c2

main () {
	clear
	echoR "Installing Software"
	echoL "Downloading Gzip (1.14)..."

	echo "Downloading Gzip (1.14)... "
	../bash/Download.sh https://ftp.gnu.org/gnu/gzip/gzip-1.14.tar.xz gzip-1.14.tar.xz
	cp ../Packages/gzip-1.14.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Gzip (1.14)..."
	sleep 2
	rm -fR gzip-1.14
	tar -vxsf gzip-1.14.tar.xz
	cd gzip-1.14

	echoL "Building Gzip (1.14)..."
	./configure --prefix=/usr --host=$LFS_TGT
	make

	echoL "Installing Gzip (1.14)..."
	make DESTDIR=$LFS install

	echoL "Install Complete Gzip (1.14)"
	sleep 2
	cd $LFS/sources
	rm -fR gzip-1.14

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
