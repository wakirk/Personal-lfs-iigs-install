#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# GMP (6.3.0) - 2,046 KB:
	# Home page: https://www.gnu.org/software/gmp/
	# Download: https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
	# MD5 sum: 956dc04e864001a9c22429f761f2c283
	echoR "System Software"

	echoL "Downloading GMP (6.3.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz gmp-6.3.0.tar.xz
	cp ../Packages/gmp-6.3.0.tar.xz /sources

	echoL "Unpack GMP (6.3.0)..."
	sleep 2
	cd /sources
	rm -fR gmp-6.3.0
	tar -vxsf gmp-6.3.0.tar.xz
	cd gmp-6.3.0

	echoL "Building GMP (6.3.0)..."
	sleep 2
	sed -i '/long long t1;/,+1s/()/(...)/' configure
	./configure --prefix=/usr  \
		--enable-cxx           \
		--disable-static       \
		--docdir=/usr/share/doc/gmp-6.3.0
	make
	make html

	echoL "Testing GMP (6.3.0)..."
	sleep 2
	make check 2>&1 | tee gmp-check-log
	awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log

	echoL "Installing GMP (6.3.0)..."
	sleep 2
	make install
	make install-html

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gmp-6.3.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
