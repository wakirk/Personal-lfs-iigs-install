#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

Bison (3.8.2) - 2,752 KB:
Home page: https://www.gnu.org/software/bison/
Download: https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz
MD5 sum: c28f119f405a2304ff0a7ccdcc629713
	echoR "System Software"

	echoL "Downloading Bison (3.8.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz bison-3.8.2.tar.xz
	cp ../Packages/bison-3.8.2.tar.xz /sources

	echoL "Unpack Bison (3.8.2)..."
	sleep 2
	cd /sources
	rm -fR bison-3.8.2
	tar -vxsf bison-3.8.2.tar.xz
	cd bison-3.8.2

	echoL "Building Bison (3.8.2)..."
	sleep 2
  ./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.8.2
make

	echoL "Testing Bison (3.8.2)..."
	sleep 2
make check
/bin/bash

	echoL "Installing Bison (3.8.2)..."
	sleep 2
make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR bison-3.8.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
