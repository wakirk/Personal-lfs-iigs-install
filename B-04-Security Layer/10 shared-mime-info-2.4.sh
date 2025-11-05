#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# 09 shared-mime-info-2.4.sh	# https://www.linuxfromscratch.org/blfs/view/stable/general/shared-mime-info.html

	# Required
	#	GLib-2.84.4
	#	libxml2-2.14.5

	# Optional
	#	xmlto-0.0.29

main () {

	# Download (HTTP): https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/2.4/shared-mime-info-2.4.tar.gz
	# Download MD5 sum: aac56db912b7b12a04fb0018e28f2f36
	# Download size: 7.5 MB
	# Estimated disk space required: 26 MB (with tests)
	# Estimated build time: less than 0.1 SBU (with tests)

	# Additional Downloads
	# Optional download, required to run the test suite: https://anduin.linuxfromscratch.org/BLFS/xdgmime/xdgmime.tar.xz
	# xdgmime md5sum: 7dfb4446705d345d3acd672024049e86
	echoR "Group 4 Security Layer"

	echoL "Downloading shared mime info (2.4)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/2.4/shared-mime-info-2.4.tar.gz shared-mime-info-2.4.tar.gz
	cp ../Packages/shared-mime-info-2.4.tar.gz /sources

	../bash/Download.sh https://anduin.linuxfromscratch.org/BLFS/xdgmime/xdgmime.tar.xz xdgmime.tar.xz
	cp ../Packages/xdgmime.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack shared mime info (2.4)..."
	sleep 2
	cd /sources
	rm -fR shared-mime-info-2.4
	tar -vxsf shared-mime-info-2.4.tar.gz
	cd shared-mime-info-2.4

	echoL "Building shared mime info (2.4)..."
	sleep 2
	tar -xf ../xdgmime.tar.xz &&
	make -C xdgmime
	mkdir build &&
	cd    build &&
	meson setup --prefix=/usr --buildtype=release -D update-mimedb=true .. &&
	ninja

	echoL "Testing shared mime info (2.4)..."
	sleep 2
	ninja test

	echoL "Installing shared mime info (2.4)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR shared-mime-info-2.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
