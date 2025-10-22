#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Tar (1.35) - 2,263 KB:
#Home page: https://www.gnu.org/software/tar/
#Download: https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz
#MD5 sum: a2d8042658cfd8ea939e6d911eaf4152

main () {
	clear
	echoR "Installing Software Tar (1.35)"
	echoL "Downloading Tar (1.35)..."

	echo "Downloading Tar (1.35)... "
	../bash/Download.sh https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz tar-1.35.tar.xz
	cp ../Packages/tar-1.35.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Tar (1.35)..."
	sleep 2
	rm -fR tar-1.35
	clear 
	tar -vxsf tar-1.35.tar.xz
	cd tar-1.35

	echoL "Building Tar (1.35)..."
	./configure --prefix=/usr   \
		--host=$LFS_TGT \
		--build=$(build-aux/config.guess)
	make

	echoL "Installing Tar (1.35)..."
	make DESTDIR=$LFS install 
	
	echoL "Install Complete Tar (1.35)"
	sleep 2
	cd $LFS/sources
	rm -fR tar-1.35

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
