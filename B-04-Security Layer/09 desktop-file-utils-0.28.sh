#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	#	08 desktop-file-utils-0.28.sh
	#	https://www.linuxfromscratch.org/blfs/view/stable/general/desktop-file-utils.html

	# Required
	#	GLib-2.84.4
	# Optional
	#	Emacs-30.2

main () {

	# Download (HTTP): https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.28.tar.xz
	# Download MD5 sum: dec5d7265c802db1fde3980356931b7b
	# Download size: 80 KB
	# Estimated disk space required: 1.2 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 4 Security Layer"

	echoL "Downloading Desktop File-utils (0.28)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.28.tar.xz desktop-file-utils-0.28.tar.xz
	cp ../Packages/desktop-file-utils-0.28.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Desktop File-utils (0.28)..."
	sleep 2
	cd /sources
	rm -fR desktop-file-utils-0.28
	tar -vxsf desktop-file-utils-0.28.tar.xz
	cd desktop-file-utils-0.28

	echoL "Building Desktop File-utils (0.28)..."
	sleep 2
	rm -fv /usr/bin/desktop-file-edit
	mkdir build &&
	cd    build &&
	meson setup --prefix=/usr --buildtype=release ..
	ninja

	echoL "Installing Desktop File-utils (0.28)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR desktop-file-utils-0.28

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
