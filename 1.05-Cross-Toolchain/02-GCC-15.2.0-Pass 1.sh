#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#GCC (15.2.0) - 98,688 KB:
#Home page: https://gcc.gnu.org/
#Download: https://ftp.gnu.org/gnu/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz
#MD5 sum: b861b092bf1af683c46a8aa2e689a6fd

#MPFR (4.2.2) - 1,471 KB:
#Home page: https://www.mpfr.org/
#Download: https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.2.tar.xz
#MD5 sum: 7c32c39b8b6e3ae85f25156228156061

#GMP (6.3.0) - 2,046 KB:
#Home page: https://www.gnu.org/software/gmp/
#Download: https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
#MD5 sum: 956dc04e864001a9c22429f761f2c283

#MPC (1.3.1) - 756 KB:
#Home page: https://www.multiprecision.org/
#Download: https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
#MD5 sum: 5c9bc658c9fd0f940e8e3e0f09530c62


main () {
	clear

	echoR "Installing Software"
	echoL "Downloading GCC (15.2.0)..."
	echo "Downloading... GCC (15.2.0)..."
	../bash/Download.sh https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-15.2.0/gcc-15.2.0.tar.gz gcc-15.2.0.tar.xz
	../bash/Download.sh https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.2.tar.xz mpfr-4.2.2.tar.xz
	../bash/Download.sh https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz gmp-6.3.0.tar.xz
	../bash/Download.sh https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz mpc-1.3.1.tar.gz

	cp -fv  ../Packages/gcc-15.2.0.tar.xz $LFS/sources
	cp -fv  ../Packages/mpfr-4.2.2.tar.xz $LFS/sources
	cp -fv  ../Packages/gmp-6.3.0.tar.xz  $LFS/sources
	cp -fv  ../Packages/mpc-1.3.1.tar.gz  $LFS/sources

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

	case $(uname -m) in
	x86_64)
		sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
	;;
	esac

	echoL "Building GCC (15.2.0)..."
	mkdir -v build
	cd       build

	CPP="gcc -E"
../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.42 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++

	make

	echoL "Installing GCC (15.2.0)..."
	make install
	cd ..
	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

	echoL "Install Complete GCC (15.2.0)"
	sleep 2
	cd ..
	cd ..
#	rm -fR gcc-15.2.0  nope. we use it later.

	exit 1
}


lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

