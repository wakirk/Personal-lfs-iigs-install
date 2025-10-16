#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	# Bzip2 (1.0.8) - 792 KB:
	# Download: https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
	# MD5 sum: 67e051268d0c475ea773822f7500d0e5

	# Bzip2 Documentation Patch - 1.6 KB:
	# Download: https://www.linuxfromscratch.org/patches/lfs/12.4/bzip2-1.0.8-install_docs-1.patch
	# MD5 sum: 6a5ac7e89b791aae556de0f745916f7f

	echoL "Downloading Bzip2 (1.0.8)..."
	echoR "System Software"
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz bzip2-1.0.8.tar.gz
	cp ../Packages/bzip2-1.0.8.tar.gz /sources

	sleep 2
	echoL "Downloading Bzip2 Documentation Patch..."
	../bash/Download.sh https://www.linuxfromscratch.org/patches/lfs/12.4/bzip2-1.0.8-install_docs-1.patch bzip2-1.0.8-install_docs-1.patch
	cp ../Packages/bzip2-1.0.8-install_docs-1.patch /sources

	echoL "Unpack Bzip2 (1.0.8)..."
	sleep 2
	cd /sources
	rm -fR bzip2-1.0.8
	tar -vxsf bzip2-1.0.8.tar.gz
	cd bzip2-1.0.8

	echoL "Building Bzip2 (1.0.8)..."
	sleep 2
	patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch
	sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
	make -f Makefile-libbz2_so
	make clean
	make

	echoL "Installing Bzip2 (1.0.8)..."
	sleep 2
	make PREFIX=/usr install
	cp -av libbz2.so.* /usr/lib
	ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so
	cp -v bzip2-shared /usr/bin/bzip2
	for i in /usr/bin/{bzcat,bunzip2}; do
		ln -sfv bzip2 $i
	done
	rm -fv /usr/lib/libbz2.a
	
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR bzip2-1.0.8.tar.gz

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
