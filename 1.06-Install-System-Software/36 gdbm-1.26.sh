#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# GDBM (1.26) - 1,198 KB:
	# Home page: https://www.gnu.org/software/gdbm/
	# Download: https://ftp.gnu.org/gnu/gdbm/gdbm-1.26.tar.gz
	# MD5 sum: aaa600665bc89e2febb3c7bd90679115
	echoR "System Software"

	echoL "Downloading ------- ( ) ..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://*.tar.xz *.tar.xz
	cp ../Packages/-.tar.xz /sources

	echoL "Unpack ------- ( ) ..."
	sleep 2
	cd /sources
	rm -fR
	tar -vxsf
	cd 

	echoL "Building ------- ( ) ..."
	sleep 2

	echoL "Installing ------- ( ) ..."
	sleep 2

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR 

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1





.38.1. Installation of GDBM
Prepare GDBM for compilation:

./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat
The meaning of the configure option:

--enable-libgdbm-compat
This switch enables building the libgdbm compatibility library. Some packages outside of LFS may require the older DBM routines it provides.

Compile the package:

make
To test the results, issue:

make check
Install the package:

make install
8.38.2. Contents of GDBM
