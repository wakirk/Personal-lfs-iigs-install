#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	Fontconfig-2.17.1 (must be built with FreeType-2.13.3 using harfBuzz-11.4.1)
	#	FriBidi-1.0.16
	#	GLib-2.84.4 (GObject Introspection required for GNOME)

	# Recommended
	#	Cairo-1.18.4 (built after harfBuzz-11.4.1)
	#	Xorg Libraries

	# Optional
	#	Gi-DocGen-2025.4 (to generate documentation)
	#	help2man
	#	libthai
	#	sysprof

main () {

	# Download (HTTP): https://download.gnome.org/sources/pango/1.56/pango-1.56.4.tar.xz
	# Download MD5 sum: 3db267bc07bfd96615c652e9187b85b5
	# Download size: 1.8 MB
	# Estimated disk space required: 22 MB (with tests)
	# Estimated build time: less than 0.1 SBU (Using parallelism=4; with tests)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Pango (1.56.4)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://download.gnome.org/sources/pango/1.56/pango-1.56.4.tar.xz pango-1.56.4.tar.xz
	cp ../Packages/pango-1.56.4.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Pango (1.56.4)..."
	sleep 2
	cd /sources
	rm -fR pango-1.56.4
	tar -vxsf pango-1.56.4.tar.xz
	cd pango-1.56.4

	echoL "Building Pango (1.56.4)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=/usr            \
				--buildtype=release      \
				--wrap-mode=nofallback   \
				-D introspection=enabled \
	..
	ninja

	echoL "Testing Pango (1.56.4)..."
	sleep 2
	ninja test

	echoL "Installing Pango (1.56.4)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR pango-1.56.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
