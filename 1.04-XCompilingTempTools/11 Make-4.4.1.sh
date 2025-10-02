#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Make (4.4.1) - 2,300 KB:
#Home page: https://www.gnu.org/software/make/
#Download: https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz
#MD5 sum: c8469a3713cbbe04d955d4ae4be23eeb

main () {
	clear
	echoR "Installing Software"
	echoL "Downloading Make (4.4.1)..."

	echo "Downloading Make (4.4.1)..."
	../bash/Download.sh https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz make-4.4.1.tar.gz
	cp ../Packages/make-4.4.1.tar.gz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Make (4.4.1)..."
	sleep 2
	rm -fR make-4.4.1
	tar -vxsf make-4.4.1.tar.gz
	cd make-4.4.1

	echoL "Building Make (4.4.1)..."
	./configure --prefix=/usr   \
		--host=$LFS_TGT \
		--build=$(build-aux/config.guess)
	make

	echoL "Installing Make (4.4.1)..."
	make DESTDIR=$LFS install

	echoL "Install Complete Make (4.4.1)"
	sleep 2
	cd ..
	rm -fR make-4.4.1

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
