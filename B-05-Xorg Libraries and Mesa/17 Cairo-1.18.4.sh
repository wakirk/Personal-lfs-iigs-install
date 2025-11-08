#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	libpng-1.6.50
	#	Pixman-0.46.4

	# Recommended
	#	Fontconfig-2.17.1
	#	GLib-2.84.4 (required for most GUIs)
	#	Xorg Libraries

	# Optional
	#	ghostscript-10.05.1
	#	GTK-Doc-1.34.0
	#	libdrm-2.4.125
	#	librsvg-2.61.0
	#	libxml2-2.14.5
	#	LZO-2.10
	#	Poppler-25.08.0
	#	Valgrind-3.25.1
	#	GTK+-2
	#	and libspectre

	# [Note] Note
	# There is a circular dependency between cairo and harfbuzz. If cairo is
	# built before harfbuzz, it is necessary to rebuild cairo after harfbuzz
	# in order to build pango.


main () {

	# Download (HTTP): https://www.cairographics.org/releases/cairo-1.18.4.tar.xz
	# Download MD5 sum: db575fb41bbda127e0147e401f36f8ac
	# Download size: 31 MB
	# Estimated disk space required: 95 MB
	# Estimated build time: 0.2 SBU (Using parallelism=4)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Cairo (1.18.4)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://www.cairographics.org/releases/cairo-1.18.4.tar.xz cairo-1.18.4.tar.xz
	cp ../Packages/cairo-1.18.4.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Cairo (1.18.4)..."
	sleep 2
	cd /sources
	rm -fR cairo-1.18.4
	tar -vxsf cairo-1.18.4.tar.xz
	cd cairo-1.18.4

	echoL "Building Cairo (1.18.4)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=/usr --buildtype=release .. &&
	ninja
	read

	echoL "Installing Cairo (1.18.4)..."
	sleep 2
	ninja install
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR cairo-1.18.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
