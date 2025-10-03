#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Bash (5.3) - 11,089 KB:
#Home page: https://www.gnu.org/software/bash/
#Download: https://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz
#MD5 sum: 977c8c0c5ae6309191e7768e28ebc951

main () {
	clear
	echoR "Installing Software"
	echoL "Downloading Bash (5.3)..."

	echo "Downloading Bash (5.3)... "
	../bash/Download.sh https://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz bash-5.3.tar.gz
	cp ../Packages/bash-5.3.tar.gz $LFS/sources
	cd $LFS/sources
	ls

	echoL "Unpack: Bash (5.3)..."
	sleep 2
	rm -fR bash-5.3
	tar -vxsf bash-5.3.tar.gz
	cd bash-5.3

	echoL "Building Bash (5.3)..."
	./configure --prefix=/usr				\
		--build=$(sh support/config.guess)	\
		--host=$LFS_TGT						\
		--without-bash-malloc
	make

	echoL "Installing Bash (5.3)..."
	make DESTDIR=$LFS install
	ln -sv bash $LFS/bin/sh

	echoL "Install Complete Bash (5.3)"
	sleep 2
	cd ..
	rm -fR bash-5.3

	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
