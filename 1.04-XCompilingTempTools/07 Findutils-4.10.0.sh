#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Findutils (4.10.0) - 2,189 KB:
#Home page: https://www.gnu.org/software/findutils/
#Download: https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz
#MD5 sum: 870cfd71c07d37ebe56f9f4aaf4ad872

main () {
	clear
	echoR "Installing Software Findutils (4.10.0)"
	echoL "Downloading Findutils (4.10.0)..."

	echo "Downloading Findutils (4.10.0)... "
	../bash/Download.sh https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz findutils-4.10.0.tar.xz
	cp ../Packages/findutils-4.10.0.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Findutils (4.10.0)..."
	sleep 2
	rm -fR findutils-4.10.0
	tar -vxsf findutils-4.10.0.tar.xz
	cd findutils-4.10.0

	echoL "Building Findutils (4.10.0)..."
	./configure --prefix=/usr           \
		--localstatedir=/var/lib/locate \
		--host=$LFS_TGT                 \
		--build=$(build-aux/config.guess)
	make

	echoL "Installing Findutils (4.10.0)..."
	make DESTDIR=$LFS install

	echoL "Install Complete Findutils (4.10.0)"
	sleep 2
	cd $LFS/sources
	rm -fR findutils-4.10.0

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
