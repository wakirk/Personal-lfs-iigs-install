#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Coreutils (9.7) - 6,015 KB:
#Home page: https://www.gnu.org/software/coreutils/
#Download: https://ftp.gnu.org/gnu/coreutils/coreutils-9.7.tar.xz
#MD5 sum: 6b7285faf7d5eb91592bdd689270d3f1

main () {
	clear
	echoR "Installing Software Coreutils (9.7)"
	echoL "Downloading Coreutils (9.7)..."

	echo "Downloading Coreutils (9.7)... "
	../bash/Download.sh https://ftp.gnu.org/gnu/coreutils/coreutils-9.7.tar.xz coreutils-9.7.tar.xz
	cp ../Packages/coreutils-9.7.tar.xz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Coreutils (9.7)..."
	sleep 2
	rm -fR coreutils-9.7
	tar -vxsf coreutils-9.7.tar.xz
	cd coreutils-9.7

	echoL "Building Coreutils (9.7)..."
	./configure --prefix=/usr				\
		--host=$LFS_TGT						\
		--build=$(build-aux/config.guess)	\
		--enable-install-program=hostname	\
		--enable-no-install-program=kill,uptime
	make

	echoL "Installing Coreutils (9.7)..."
	make DESTDIR=$LFS install
	mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin
	mkdir -pv $LFS/usr/share/man/man8
	mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
	sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8

	echoL "Install Complete Coreutils (9.7)"
	sleep 2
	cd ..
	rm -fR coreutils-9.7

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
