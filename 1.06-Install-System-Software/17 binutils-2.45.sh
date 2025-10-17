#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Binutils (2.45) - 27,216 KB:
	# Home page: https://www.gnu.org/software/binutils/
	# Download: https://sourceware.org/pub/binutils/releases/binutils-2.45.tar.xz
	# MD5 sum: dee5b4267e0305a99a3c9d6131f45759
	echoR "System Software"

	echoL "Downloading Binutils (2.45)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://sourceware.org/pub/binutils/releases/binutils-2.45.tar.xz binutils-2.45.tar.xz
	cp ../Packages/binutils-2.45.tar.xz /sources

	echoL "Unpack Binutils (2.45)..."
	sleep 2
	cd /sources
	rm -fR binutils-2.45
	tar -vxsf binutils-2.45.tar.xz
	cd binutils-2.45

	echoL "Building Binutils (2.45)..."
	sleep 2
	mkdir -v build
	cd       build
	../configure --prefix=/usr \
		--sysconfdir=/etc      \
		--enable-ld=default    \
		--enable-plugins       \
		--enable-shared        \
		--disable-werror       \
		--enable-64-bit-bfd    \
		--enable-new-dtags     \
		--with-system-zlib     \
		--enable-default-hash-style=gnu
	make tooldir=/usr


	echoL "Testing Binutils (2.45)..."
	make -k check
	grep '^FAIL:' $(find -name '*.log')

	echoL "Installing Binutils (2.45)..."
	sleep 2
	make tooldir=/usr install
	rm -rfv /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a /usr/share/doc/gprofng/

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR binutils-2.45

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
