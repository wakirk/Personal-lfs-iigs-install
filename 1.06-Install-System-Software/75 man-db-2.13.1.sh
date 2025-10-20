#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Man-DB (2.13.1) - 2,061 KB:
	# Home page: https://www.nongnu.org/man-db/
	# Download: https://download.savannah.gnu.org/releases/man-db/man-db-2.13.1.tar.xz
	# MD5 sum: b6335533cbeac3b24cd7be31fdee8c83
	echoR "System Software"

	echoL "Downloading Man-DB (2.13.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://download.savannah.gnu.org/releases/man-db/man-db-2.13.1.tar.xz man-db-2.13.1.tar.xz
	cp ../Packages/man-db-2.13.1.tar.xz /sources

	echoL "Unpack Man-DB (2.13.1)..."
	sleep 2
	cd /sources
	rm -fR man-db-2.13.1
	tar -vxsf man-db-2.13.1.tar.xz
	cd man-db-2.13.1

	echoL "Building Man-DB (2.13.1)..."
	sleep 2
	./configure --prefix=/usr                 \
		--docdir=/usr/share/doc/man-db-2.13.1 \
		--sysconfdir=/etc                     \
		--disable-setuid                      \
		--enable-cache-owner=bin              \
		--with-browser=/usr/bin/lynx          \
		--with-vgrind=/usr/bin/vgrind         \
		--with-grap=/usr/bin/grap             \
		--with-systemdtmpfilesdir=            \
		--with-systemdsystemunitdir=
	make

	echoL "Testing Man-DB (2.13.1)..."
	sleep 2
	make check

	echoL "Installing Man-DB (2.13.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR man-db-2.13.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
