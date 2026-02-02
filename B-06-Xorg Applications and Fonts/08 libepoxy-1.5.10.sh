#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	Mesa-25.1.8

	# Optional
	#	Doxygen-1.14.0 (for documentation)

main () {

	# Download (HTTP): https://download.gnome.org/sources/libepoxy/1.5/libepoxy-1.5.10.tar.xz
	# Download MD5 sum: 10c635557904aed5239a4885a7c4efb7
	# Download size: 220 KB
	# Estimated disk space required: 13 MB (with tests)
	# Estimated build time: 0.1 SBU (with tests)
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading libepoxy (1.5.10)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://download.gnome.org/sources/libepoxy/1.5/libepoxy-1.5.10.tar.xz libepoxy-1.5.10.tar.xz
	cp ../Packages/libepoxy-1.5.10.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libepoxy (1.5.10)..."
	sleep 2
	cd /sources
	rm -fR libepoxy-1.5.10
	tar -vxsf libepoxy-1.5.10.tar.xz
	cd libepoxy-1.5.10

	echoL "Building libepoxy (1.5.10)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=/usr --buildtype=release .. &&
	ninja

	echoL "Testing libepoxy (1.5.10)..."
	sleep 2
	ninja test

	echoL "Installing libepoxy (1.5.10)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libepoxy-1.5.10

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
