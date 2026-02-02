#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Attr (2.5.2) - 484 KB:
	# Home page: https://savannah.nongnu.org/projects/attr
	# Download: https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz
	# MD5 sum: 227043ec2f6ca03c0948df5517f9c927
	echoR "System Software"

	echoL "Downloading Attr (2.5.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz attr-2.5.2.tar.gz
	cp ../Packages/attr-2.5.2.tar.gz /sources

	echoL "Unpack Attr (2.5.2)..."
	sleep 2
	cd /sources
	rm -fR attr-2.5.2
	tar -vxsf attr-2.5.2.tar.gz
	cd attr-2.5.2

	echoL "Building Attr (2.5.2)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--sysconfdir=/etc     \
		--docdir=/usr/share/doc/attr-2.5.2
	make

	echoL "Testing Attr (2.5.2)..."
	sleep 2
	make check

	echoL "Installing Attr (2.5.2)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR attr-2.5.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
