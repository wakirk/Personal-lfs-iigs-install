#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# M4 (1.4.20) - 1,997 KB:
	# Home page: https://www.gnu.org/software/m4/
	# Download: https://ftp.gnu.org/gnu/m4/m4-1.4.20.tar.xz
	# MD5 sum: 6eb2ebed5b24e74b6e890919331d2132
	echoR "System Software"

	echoL "Downloading M4 (1.4.20)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/m4/m4-1.4.20.tar.xz m4-1.4.20.tar.xz
	cp ../Packages/m4-1.4.20.tar.xz /sources

	echoL "Unpack M4 (1.4.20)..."
	sleep 2
	cd /sources
	rm -fR m4-1.4.20
	tar -vxsf m4-1.4.20.tar.xz
	cd m4-1.4.20

	echoL "Building M4 (1.4.20)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Testing M4 (1.4.20)..."
	make check
	sleep 2

	echoL "Installing M4 (1.4.20)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR m4-1.4.20

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1

















