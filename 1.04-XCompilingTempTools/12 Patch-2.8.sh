#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Patch (2.8) - 886 KB:
#Home page: https://savannah.gnu.org/projects/patch/
#Download: https://ftp.gnu.org/gnu/patch/patch-2.8.tar.xz
#MD5 sum: 149327a021d41c8f88d034eab41c039f

main () {
	clear
	echoR "Installing Software"
	echoL "Downloading Patch (2.8)..."

	echo "Downloading Patch (2.8)... "
	../bash/Download.sh https://ftp.gnu.org/gnu/patch/patch-2.8.tar.xz patch-2.8.tar.xz
	cp ../Packages/patch-2.8.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Patch (2.8)..."
	sleep 2
	rm -fR patch-2.8
	tar -vxsf patch-2.8.tar.xz
	cd patch-2.8

	echoL "Building Patch (2.8)..."
	./configure --prefix=/usr  \
		--host=$LFS_TGT        \
		--build=$(build-aux/config.guess)
	make

	echoL "Installing Patch (2.8)..."
	make DESTDIR=$LFS install

	echoL "Install Complete Patch (2.8)"
	sleep 2
	cd $LFS/sources
	rm -fR patch-2.8

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
