#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Binutils (2.45) - 27,216 KB:
#Home page: https://www.gnu.org/software/binutils/
#Download: https://sourceware.org/pub/binutils/releases/binutils-2.45.tar.xz
#MD5 sum: dee5b4267e0305a99a3c9d6131f45759

main () {
	clear

	echoR "Installing Software"
	echoL "Downloading Binutils (2.45)..."
	echo "Downloading... Binutils (2.45)"
	../bash/Download.sh https://sourceware.org/pub/binutils/releases/binutils-2.45.tar.xz binutils-2.45.tar.xz
	cp ../Packages/binutils-2.45.tar.xz $LFS/sources
	cd $LFS/sources
	ls -l

	echoL "Unpack: Binutils (2.45)..."
	sleep 2
	rm -fR binutils-2.45
	tar -vxsf binutils-2.45.tar.xz
	cd binutils-2.45

	echoL "Building Binutils (2.45)..."
	mkdir -v build
	cd       build

	CPP="gcc -E"
	../configure --prefix=$LFS/tools \
				--with-sysroot=$LFS \
				--target=$LFS_TGT   \
				--disable-nls       \
				--enable-gprofng=no \
				--disable-werror    \
				--enable-new-dtags  \
				--enable-default-hash-style=gnu
	make

	echoL "Installing Binutils (2.45)..."
	make install

	echoL "Install Complete Binutils (2.45)"
	sleep 2
	cd ..
	cd ..
	rm -fR binutils-2.45

	exit 1
}


#lfs_identity
#lfs_tmux_entry main  # must be called after the routine it defines.
main

