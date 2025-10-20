#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Make (4.4.1) - 2,300 KB:
	# Home page: https://www.gnu.org/software/make/
	# Download: https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz
	# MD5 sum: c8469a3713cbbe04d955d4ae4be23eeb
	echoR "System Software"

	echoL "Downloading Make (4.4.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz make-4.4.1.tar.gz
	cp ../Packages/make-4.4.1.tar.gz /sources

	echoL "Unpack Make (4.4.1)..."
	sleep 2
	cd /sources
	rm -fR make-4.4.1
	tar -vxsf make-4.4.1.tar.gz
	cd make-4.4.1

	echoL "Building Make (4.4.1)..."
	sleep 2
	./configure --prefix=/usr
	make

	echoL "Testing Make (4.4.1)..."
	sleep 2
	chown -R tester .
	su tester -c "PATH=$PATH make check"

	echoL "Installing Make (4.4.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR make-4.4.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
