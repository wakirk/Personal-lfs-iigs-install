#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Glibc (2.42) - 19,464 KB:
#Home page: https://www.gnu.org/software/libc/
#Download: https://ftp.gnu.org/gnu/glibc/glibc-2.42.tar.xz
#MD5 sum: 23c6f5a27932b435cae94e087cb8b1f5

#Glibc FHS Patch - 2.8 KB:
#Download: https://www.linuxfromscratch.org/patches/lfs/12.4/glibc-2.42-fhs-1.patch
#MD5 sum: 9a5997c3452909b1769918c759eff8a2



main () {
	clear
	echoR "Installing Software"
	echoL "Downloading Glibc (2.42)..."

	echo "Downloading Glibc (2.42)..."
	/home/lfs/lfs/bash/download.sh https://mirrors.ocf.berkeley.edu/gnu/glibc/glibc-2.42.tar.xz glibc-2.42.tar.xz
	/home/lfs/lfs/bash/download.sh https://www.linuxfromscratch.org/patches/lfs/12.4/glibc-2.42-fhs-1.patch glibc-2.42-fhs-1.patch
	cp -fv /home/lfs/lfs/Packages/glibc-2.42.tar.xz $LFS/sources
	cp -fv /home/lfs/lfs/Packages/glibc-2.42-fhs-1.patch $LFS/sources
	cd $LFS/sources

	echoL "Unpack: Glibc (2.42)..."
	sleep 2
	rm -fR glibc-2.42
	tar -vxsf glibc-2.42.tar.xz
	cd glibc-2.42

	echoL "Building Glibc (2.42)..."
	case $(uname -m) in
		i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
		;;
		x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
				ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
		;;
	esac
	patch -Np1 -i ../glibc-2.42-fhs-1.patch
	mkdir -v build
	cd       build
	echo "rootsbindir=/usr/sbin" > configparms
	../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --disable-nscd                     \
      libc_cv_slibdir=/usr/lib           \
      --enable-kernel=5.4
	make

	echoL "Installing Glibc (2.42)..."
	make DESTDIR=$LFS install
	sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
	echo 'int main(){}' | $LFS_TGT-gcc -x c - -v -Wl,--verbose &> dummy.log
	readelf -l a.out | grep ': /lib'
	grep -E -o "$LFS/lib.*/S?crt[1in].*succeeded" dummy.log
	grep -B3 "^ $LFS/usr/include" dummy.log
	grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
	grep "/lib.*/libc.so.6 " dummy.log
	grep found dummy.log
	rm -v a.out dummy.log
	
	echoL "Installed Glibc (2.42)"
	sleep 2
	cd ..
	cd ..
	rm -fR glibc-2.42
	exit 1
}


lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
