#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# MPFR (4.2.2) - 1,471 KB:
	# Home page: https://www.mpfr.org/
	# Download: https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.2.tar.xz
	# MD5 sum: 7c32c39b8b6e3ae85f25156228156061
	echoR "System Software"

	echoL "Downloading MPFR (4.2.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.2.tar.xz mpfr-4.2.2.tar.xz
	cp ../Packages/mpfr-4.2.2.tar.xz /sources

	echoL "Unpack MPFR (4.2.2)..."
	sleep 2
	cd /sources
	rm -fR mpfr-4.2.2
	tar -vxsf mpfr-4.2.2.tar.xz
	cd mpfr-4.2.2

	echoL "Building MPFR (4.2.2)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--enable-thread-safe  \
		--docdir=/usr/share/doc/mpfr-4.2.2
	make
	make html

	echoL "Testing MPFR (4.2.2)..."
	sleep 2
	make check				# Test the results and ensure that all 198 tests passed:
	make check | grep '198'
	
	echoL "Installing MPFR (4.2.2)..."
	sleep 2
	make install
	make install-html

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR mpfr-4.2.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
