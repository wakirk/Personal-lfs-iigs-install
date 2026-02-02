#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#GCC (15.2.0) - 98,688 KB:
#Home page: https://gcc.gnu.org/
#Download: https://ftp.gnu.org/gnu/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz
#MD5 sum: b861b092bf1af683c46a8aa2e689a6fd

main () {
	clear
	echoR "Installing Software GCC (15.2.0) Pass 2"
	cd $LFS/sources
	ls

	cp -fv  /home/lfs/lfs/Packages/gcc-15.2.0.tar.xz $LFS/sources
	cp -fv  /home/lfs/lfs/Packages/mpfr-4.2.2.tar.xz $LFS/sources
	cp -fv  /home/lfs/lfs/Packages/gmp-6.3.0.tar.xz  $LFS/sources
	cp -fv  /home/lfs/lfs/Packages/mpc-1.3.1.tar.gz  $LFS/sources
	cd $LFS/sources
	echoL "Unpack: GCC (15.2.0)..."
	sleep 2
	rm -fR gcc-15.2.0
	tar -vxsf gcc-15.2.0.tar.xz
	cd gcc-15.2.0
	# Book Instructions for add-on modules to GCC
	tar -vxf ../mpfr-4.2.2.tar.xz
	mv -v mpfr-4.2.2 mpfr
	tar -vxf ../gmp-6.3.0.tar.xz
	mv -v gmp-6.3.0 gmp
	tar -vxf ../mpc-1.3.1.tar.gz
	mv -v mpc-1.3.1 mpc

	echoL "Building GCC (15.2.0) Pass 2..."
	case $(uname -m) in
		x86_64)
			sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
		;;
	esac
	sed '/thread_header =/s/@.*@/gthr-posix.h/' -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in
	mkdir -v build
	cd       build
	../configure                   \
		--build=$(../config.guess) \
		--host=$LFS_TGT            \
		--target=$LFS_TGT          \
		--prefix=/usr              \
		--with-build-sysroot=$LFS  \
		--enable-default-pie       \
		--enable-default-ssp       \
		--disable-nls              \
		--disable-multilib         \
		--disable-libatomic        \
		--disable-libgomp          \
		--disable-libquadmath      \
		--disable-libsanitizer     \
		--disable-libssp           \
		--disable-libvtv           \
		--enable-languages=c,c++   \
	LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc
	make

	echoL "Installing GCC (15.2.0) Pass 2..."
	make DESTDIR=$LFS install
	ln -sv gcc $LFS/usr/bin/cc

	echoL "Install Complete GCC (15.2.0) Pass 2"
	sleep 2
	cd $LFS/sources
	rm -fR gcc-15.2.0

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
