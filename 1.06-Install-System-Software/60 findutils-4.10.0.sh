#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Findutils (4.10.0) - 2,189 KB:
	# Home page: https://www.gnu.org/software/findutils/
	# Download: https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz
	# MD5 sum: 870cfd71c07d37ebe56f9f4aaf4ad872
	echoR "System Software"

	echoL "Downloading Findutils (4.10.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz findutils-4.10.0.tar.xz
	cp ../Packages/findutils-4.10.0.tar.xz /sources

	echoL "Unpack Findutils (4.10.0)..."
	sleep 2
	cd /sources
	rm -fR findutils-4.10.0
	tar -vxsf findutils-4.10.0.tar.xz
	cd findutils-4.10.0

	echoL "Building Findutils (4.10.0)..."
	sleep 2
	./configure --prefix=/usr --localstatedir=/var/lib/locate
	make

	echoL "Testing Findutils (4.10.0)..."
	sleep 2
	chown -R tester .
	su tester -c "PATH=$PATH make check"

	echoL "Installing Findutils (4.10.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR findutils-4.10.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
