#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# DejaGNU (1.6.3) - 608 KB:
	# Home page: https://www.gnu.org/software/dejagnu/
	# Download: https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.3.tar.gz
	# MD5 sum: 68c5208c58236eba447d7d6d1326b821
	echoR "System Software"

	echoL "Downloading DejaGNU (1.6.3)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.3.tar.gz dejagnu-1.6.3.tar.gz
	cp ../Packages/dejagnu-1.6.3.tar.gz /sources

	echoL "Unpack DejaGNU (1.6.3)..."
	sleep 2
	cd /sources
	rm -fR dejagnu-1.6.3
	tar -vxsf dejagnu-1.6.3.tar.gz
	cd dejagnu-1.6.3

	echoL "Building DejaGNU (1.6.3)..."
	sleep 2
	mkdir -v build
	cd       build
	../configure --prefix=/usr
	makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
	makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

	echoL "Testing DejaGNU (1.6.3)..."
	sleep 2
	make check

	echoL "Installing DejaGNU (1.6.3)..."
	sleep 2
	make install
	install -v -dm755  /usr/share/doc/dejagnu-1.6.3
	install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3
	cd ..

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR dejagnu-1.6.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
