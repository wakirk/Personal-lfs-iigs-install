#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Sed (4.9) - 1,365 KB:
	# Home page: https://www.gnu.org/software/sed/
	# Download: https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz
	# MD5 sum: 6aac9b2dbafcd5b7a67a8a9bcb8036c3
	echoR "System Software"

	echoL "Downloading Sed (4.9)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz sed-4.9.tar.xz
	cp ../Packages/sed-4.9.tar.xz /sources

	echoL "Unpack Sed (4.9)..."
	sleep 2
	cd /sources
	rm -fR sed-4.9
	tar -vxsf sed-4.9.tar.xz
	cd sed-4.9

	echoL "Building Sed (4.9)..."
	sleep 2
	./configure --prefix=/usr
	make 
	make html

	echoL "Testing Sed (4.9)..."
	chown -R tester .
	su tester -c "PATH=$PATH make check"

	echoL "Installing Sed (4.9)..."
	sleep 2
	make install
	install -d -m755           /usr/share/doc/sed-4.9
	install -m644 doc/sed.html /usr/share/doc/sed-4.9

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR sed-4.9

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
