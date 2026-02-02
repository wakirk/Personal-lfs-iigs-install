#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# GDBM (1.26) - 1,198 KB:
	# Home page: https://www.gnu.org/software/gdbm/
	# Download: https://ftp.gnu.org/gnu/gdbm/gdbm-1.26.tar.gz
	# MD5 sum: aaa600665bc89e2febb3c7bd90679115
	echoR "System Software"

	echoL "Downloading GDBM (1.26)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/gdbm/gdbm-1.26.tar.gz gdbm-1.26.tar.gz
	cp ../Packages/gdbm-1.26.tar.gz /sources

	echoL "Unpack GDBM (1.26)..."
	sleep 2
	cd /sources
	rm -fR gdbm-1.26
	tar -vxsf gdbm-1.26.tar.gz
	cd gdbm-1.26
	
	echoL "Building GDBM (1.26)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--enable-libgdbm-compat
	make

	echoL "Testing GDBM (1.26)..."
	sleep 2
	make check

	echoL "Installing GDBM (1.26)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gdbm-1.26

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
