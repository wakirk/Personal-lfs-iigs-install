#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://www.x.org/pub/individual/app/xinit-1.4.4.tar.xz
	# Download MD5 sum: e7430a710261c9129b1280f26cb159a5
	# Download size: 160 KB
	# Estimated disk space required: 1.4 MB
	# Estimated build time: less than 0.1 SBU
	echoR "System Software"

	echoL "Downloading xinit (1.4.4)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/app/xinit-1.4.4.tar.xz xinit-1.4.4.tar.xz
	cp ../Packages/xinit-1.4.4.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xinit (1.4.4)..."
	sleep 2
	cd /sources
	rm -fR xinit-1.4.4
	tar -vxsf xinit-1.4.4.tar.xz
	cd xinit-1.4.4

	echoL "Building xinit (1.4.4)..."
	sleep 2
	./configure $XORG_CONFIG --with-xinitdir=/etc/X11/app-defaults
	make

	echoL "Installing xinit (1.4.4)..."
	sleep 2
	make install
	ldconfig

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xinit-1.4.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
