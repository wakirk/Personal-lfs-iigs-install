#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Tar (1.35) - 2,263 KB:
	# Home page: https://www.gnu.org/software/tar/
	# Download: https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz
	# MD5 sum: a2d8042658cfd8ea939e6d911eaf4152
	echoR "System Software"

	echoL "Downloading Tar (1.35)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz tar-1.35.tar.xz
	cp ../Packages/tar-1.35.tar.xz /sources

	echoL "Unpack Tar (1.35)..."
	sleep 2
	cd /sources
	rm -fR tar-1.35
	tar -vxsf tar-1.35.tar.xz
	cd tar-1.35

	echoL "Building Tar (1.35)..."
	sleep 2
	FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr
	make

	echoL "Testing Tar (1.35)..."
	sleep 2
	make check
	echo "One test, capabilities: binary store/restore, is known to fail if it is run because LFS lacks selinux"

	echoL "Installing Tar (1.35)..."
	sleep 2
	make install
	make -C doc install-html docdir=/usr/share/doc/tar-1.35

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR tar-1.35

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
