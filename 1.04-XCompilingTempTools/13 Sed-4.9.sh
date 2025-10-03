#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Sed (4.9) - 1,365 KB:
#Home page: https://www.gnu.org/software/sed/
#Download: https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz
#MD5 sum: 6aac9b2dbafcd5b7a67a8a9bcb8036c3

main () {
	clear
	echoR "Installing Software Sed (4.9)"
	echoL "Downloading Sed (4.9)..."

	echo "Downloading Sed (4.9)..."
	../bash/Download.sh https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz sed-4.9.tar.xz
	cp ../Packages/sed-4.9.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Sed (4.9)..."
	sleep 2
	rm -fR sed-4.9
	tar -vxsf sed-4.9.tar.xz
	cd sed-4.9

	echoL "Building Sed (4.9)..."
	./configure --prefix=/usr   \
		--host=$LFS_TGT \
		--build=$(./build-aux/config.guess)
	make

	echoL "Installing Sed (4.9)..."
	make DESTDIR=$LFS install

	echoL "Install Complete Sed (4.9)"
	sleep 2
	cd ..
	rm -fR sed-4.9

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
