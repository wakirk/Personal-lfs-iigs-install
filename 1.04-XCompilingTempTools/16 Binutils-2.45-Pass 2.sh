#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Binutils (2.45) - 27,216 KB:
#Home page: https://www.gnu.org/software/binutils/
#Download: https://sourceware.org/pub/binutils/releases/binutils-2.45.tar.xz
#MD5 sum: dee5b4267e0305a99a3c9d6131f45759

main () {
	clear
	echoR "Installing Software Binutils (2.45) Pass 2"
	# Already downloaded...
	cd $LFS/sources
	ls

	echoL "Unpack: Binutils (2.45) Pass 2..."
	sleep 2
	rm -fR binutils-2.45      # fresh build for pass 2
	tar -vxsf binutils-2.45.tar.xz
	cd binutils-2.45

	echoL "Building Binutils (2.45) Pass 2..."
	sed '6031s/$add_dir//' -i ltmain.sh
	mkdir -v build
	cd       build
	../configure                   \
		--prefix=/usr              \
		--build=$(../config.guess) \
		--host=$LFS_TGT            \
		--disable-nls              \
		--enable-shared            \
		--enable-gprofng=no        \
		--disable-werror           \
		--enable-64-bit-bfd        \
		--enable-new-dtags         \
		--enable-default-hash-style=gnu
	make

	echoL "Installing Binutils (2.45) Pass 2..."
	make DESTDIR=$LFS install
	rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

	echoL "Install Complete Binutils (2.45) Pass 2"
	sleep 2
	cd ..
	cd ..
	rm -fR binutils-2.45

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
