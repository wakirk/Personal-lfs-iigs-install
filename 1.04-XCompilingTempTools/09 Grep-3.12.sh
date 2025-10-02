#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Grep (3.12) - 1,874 KB:
#Home page: https://www.gnu.org/software/grep/
#Download: https://ftp.gnu.org/gnu/grep/grep-3.12.tar.xz
#MD5 sum: 5d9301ed9d209c4a88c8d3a6fd08b9ac

main () {
	clear

	echoR "Installing Software"
	echoL "Downloading Grep (3.12)..."

	echo "Downloading Grep (3.12)..."
	../bash/Download.sh https://ftp.gnu.org/gnu/grep/grep-3.12.tar.xz grep-3.12.tar.xz
	cp ../Packages/grep-3.12.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Grep (3.12)..."
	sleep 2
	rm -fR grep-3.12
	tar -vxsf grep-3.12.tar.xz
	cd grep-3.12

	echoL "Building Grep (3.12)..."
	./configure --prefix=/usr	\
		--host=$LFS_TGT			\
		--build=$(build-aux/config.guess)
	make

	echoL "Installing Grep (3.12)..."
	make DESTDIR=$LFS install

	echoL "Install Complete Grep (3.12)"
	sleep 2
	cd ..
	rm -fR grep-3.12
	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
