#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Diffutils (3.12) - 1,894 KB:
#Home page: https://www.gnu.org/software/diffutils/
#Download: https://ftp.gnu.org/gnu/diffutils/diffutils-3.12.tar.xz
#MD5 sum: d1b18b20868fb561f77861cd90b05de4

main () {
	clear
	echoR "Installing Software Diffutils (3.12)"
	echoL "Downloading Diffutils (3.12)..."

	echo "Downloading Diffutils (3.12)... "
	../bash/Download.sh https://ftp.gnu.org/gnu/diffutils/diffutils-3.12.tar.xz diffutils-3.12.tar.xz
	cp ../Packages/diffutils-3.12.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Diffutils (3.12)..."
	sleep 2
	rm -fR diffutils-3.12
	tar -vxsf diffutils-3.12.tar.xz
	cd diffutils-3.12

	echoL "Building Diffutils (3.12)..."
	./configure --prefix=/usr				\
		--host=$LFS_TGT						\
		gl_cv_func_strcasecmp_works=y		\
		--build=$(./build-aux/config.guess)
	make

	echoL "Installing Diffutils (3.12)..."
	make DESTDIR=$LFS install

	echoL "Install Complete Diffutils (3.12)"
	sleep 2
	cd ..
	rm -fR diffutils-3.12
	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
