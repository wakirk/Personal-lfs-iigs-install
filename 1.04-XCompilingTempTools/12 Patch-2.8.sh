#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Patch (2.8) - 886 KB:
#Home page: https://savannah.gnu.org/projects/patch/
#Download: https://ftp.gnu.org/gnu/patch/patch-2.8.tar.xz
#MD5 sum: 149327a021d41c8f88d034eab41c039f

#main () {
#	clear
#	echoR "Installing Software"
#	echoL "Downloading ..."
#	echo "Downloading... "
#	../bash/Download.sh https*.xz *.xz
#	cp ../Packages/*.xz $LFS/sources
#	cd $LFS/sources
#	ls
#	echoL "Unpack: ..."
#	sleep 2
#	rm -fR *
#	tar -vxsf *
#	cd *
#	echoL "Building ..."
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
make
#	echoL "Installing ..."
make DESTDIR=$LFS install
#	echoL "Install Complete "
#	sleep 2
#	cd ..
#	rm -fR *
#	exit 1
#}
#lfs_identity
#lfs_tmux_entry main  # must be called after the routine it defines.
#
