#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Pkgconf (2.5.1) - 321 KB:
	# Home page: https://github.com/pkgconf/pkgconf
	# Download: https://distfiles.ariadne.space/pkgconf/pkgconf-2.5.1.tar.xz
	# MD5 sum: 3291128c917fdb8fccd8c9e7784b643b
	echoR "System Software"

	echoL "Downloading Pkgconf (2.5.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://distfiles.ariadne.space/pkgconf/pkgconf-2.5.1.tar.xz pkgconf-2.5.1.tar.xz
	cp ../Packages/pkgconf-2.5.1.tar.xz /sources

	echoL "Unpack Pkgconf (2.5.1)..."
	sleep 2
	cd /sources
	rm -fR pkgconf-2.5.1
	tar -vxsf pkgconf-2.5.1.tar.xz
	cd pkgconf-2.5.1

	echoL "Building Pkgconf (2.5.1)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--docdir=/usr/share/doc/pkgconf-2.5.1
	make

	echoL "Installing Pkgconf (2.5.1)..."
	sleep 2
	make install
	ln -fsv pkgconf   /usr/bin/pkg-config
	ln -fsv pkgconf.1 /usr/share/man/man1/pkg-config.1

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR pkgconf-2.5.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
