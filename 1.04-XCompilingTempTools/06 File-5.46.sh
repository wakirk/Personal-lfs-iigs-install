#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#File (5.46) - 1,283 KB:
#Home page: https://www.darwinsys.com/file/
#Download: https://astron.com/pub/file/file-5.46.tar.gz
#MD5 sum: 459da2d4b534801e2e2861611d823864

main () {
	clear
	echoR "Installing Software"
	echoL "Downloading File (5.46)..."

	echo "Downloading File (5.46)... "
	../bash/Download.sh https://astron.com/pub/file/file-5.46.tar.gz file-5.46.tar.gz
	cp ../Packages/file-5.46.tar.gz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: File (5.46)..."
	sleep 2
	rm -fR file-5.46
	tar -vxsf file-5.46.tar.gz
	cd file-5.46

	echoL "Building File (5.46)..."
	mkdir build
	cd    build
	../configure --disable-bzlib	\
		--disable-libseccomp		\
		--disable-xzlib				\
		--disable-zlib
	make
	cd ..
	./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)
	make FILE_COMPILE=$(pwd)/build/src/file

	echoL "Installing File (5.46)..."
	make DESTDIR=$LFS install
	rm -v $LFS/usr/lib/libmagic.la

	echoL "Install Complete File (5.46)"
	sleep 2
	cd ..
	rm -fR file-5.46

	exit 1

}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
