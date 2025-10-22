#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

main () {
	clear
	cp -fv  /home/lfs/lfs/Packages/gcc-15.2.0.tar.xz $LFS/sources
	cp -fv  /home/lfs/lfs/Packages/mpfr-4.2.2.tar.xz $LFS/sources
	cp -fv  /home/lfs/lfs/Packages/gmp-6.3.0.tar.xz  $LFS/sources
	cp -fv  /home/lfs/lfs/Packages/mpc-1.3.1.tar.gz  $LFS/sources
	cd $LFS/sources
	echoR "Installing Software"
	echoL "Unpack: GCC (15.2.0)..."
	sleep 2
	rm -fR gcc-15.2.0
	tar -vxsf gcc-15.2.0.tar.xz
	cd gcc-15.2.0

	echoL "Building Libstdc++ from GCC-15.2.0..."
	mkdir -v build
	cd       build

	../libstdc++-v3/configure      \
		--host=$LFS_TGT            \
		--build=$(../config.guess) \
		--prefix=/usr              \
		--disable-multilib         \
		--disable-nls              \
		--disable-libstdcxx-pch    \
		--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/15.2.0
	make

	echoL "Installing Libstdc++ from GCC-15.2.0..."
	make DESTDIR=$LFS install
	rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la

	echoL "Installed Libstdc++ from GCC-15.2.0..."
	sleep 2
	cd $LFS/sources
	cd gcc-15.2.0

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
