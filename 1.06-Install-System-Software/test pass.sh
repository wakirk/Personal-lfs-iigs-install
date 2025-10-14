#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

#M4 (1.4.20) - 1,997 KB:
#Home page: https://www.gnu.org/software/m4/
#Download: https://ftp.gnu.org/gnu/m4/m4-1.4.20.tar.xz
#MD5 sum: 6eb2ebed5b24e74b6e890919331d2132

main () {
#	/bin/bash

	clear
	echoR "Installing Software"
	/bin/bash
#	echoL "Downloading M4 (1.4.20) ..."

	# 10 Wget 1.25.0.sh	Wget 1.25
	# Wget-1.25.0
	# Download (HTTP): https://ftp.gnu.org/gnu/wget/wget-1.25.0.tar.gz
	# Download MD5 sum: c70ba58b36f944e8ba1d655ace552881
	# Download size: 5.0 MB
#	echoL "Downloading Wget (1.25.0)..."
#	echoR "Installing Setup Support"
#	../bash/Download.sh https://ftp.gnu.org/gnu/wget/wget-1.25.0.tar.gz wget-1.25.0.tar.gz
#	cp ../Packages/wget-1.25.0.tar.gz $LFS/sources
#	
#	echoL "Installing Wget (1.25.0)..."


#	echo "Downloading... M4 (1.4.20)"
#	../bash/Download.sh https://ftp.gnu.org/gnu/m4/m4-1.4.20.tar.xz m4-1.4.20.tar.xz
#	cp ../Packages/m4-1.4.20.tar.xz $LFS/sources
#	cd $LFS/sources
#	ls

#	echoL "Unpack: M4 (1.4.20)..."
#	sleep 2
#	rm -fR m4-1.4.20
#	tar -vxsf m4-1.4.20.tar.xz
#	cd  m4-1.4.20

#	echoL "Building M4 (1.4.20)..."
#	./configure --prefix=/usr   \
#		--host=$LFS_TGT \
#		--build=$(build-aux/config.guess)
#	make
#	
#	echoL "Installing M4 (1.4.20)..."
#	make DESTDIR=$LFS install

#	echoL "Install Complete "
#	sleep 2
#	cd ..
#	rm -fR m4-1.4.20

#	exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
