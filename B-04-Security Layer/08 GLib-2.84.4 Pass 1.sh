#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	#	07 GLib-2.84.4 Pass 1.sh
	#	https://www.linuxfromscratch.org/blfs/view/stable/general/glib2.html


	# Recommended
	#	docutils-0.21.2
	#	libxslt-1.1.43
	#	pcre2-10.45 (a copy will be downloaded from the internet if it is not installed)

	# Optional
	#	Cairo-1.18.4 (for some GObject Introspection tests)
	#	dbus-1.16.2 (for some tests)
	#	Fuse-3.17.4
	#	bindfs (both needed for one test)
	#	GDB-16.3 (for bindings)
	#	Gjs-1.84.2 (for some GObject Introspection tests)
	#	GTK-Doc-1.34.0 (for GObject Introspection documentation)
	#	docbook-xml-4.5
	#	docbook-xsl-nons-1.79.2
	#	Gi-DocGen-2025.4 (to build API documentation)
	#	glib-networking-2.80.1 (for some tests, but this is a circular dependency)
	#	Mako-1.3.10
	#	Markdown-3.8.2 (both for g-ir-doc-tool)
	#	and sysprof

	# Additional Runtime Dependencies
	# Quoted directly from the INSTALL file:
	# “Some of the mimetype-related functionality in GIO requires the update-mime-database
	#  and update-desktop-database utilities,” which are part of shared-mime-info-2.4 and
	#  desktop-file-utils-0.28, respectively. These two utilities are also needed for some tests.

main () {

	# Download (HTTP): https://download.gnome.org/sources/glib/2.84/glib-2.84.4.tar.xz
	# Download MD5 sum: 5655d0ff809b98dd77c02490609fadde
	# Download size: 5.4 MB
	# Estimated disk space required: 203 MB (add 13 MB for tests)
	# Estimated build time: 0.7 SBU (add 0.5 SBU for tests; both using parallelism=4)

	# Additional Downloads
	# GObject Introspection (Recommended)
	# Download: https://download.gnome.org/sources/gobject-introspection/1.84/gobject-introspection-1.84.0.tar.xz
	# Download MD5 sum: 2a62fb1c584616a8ebcd9dd4d045f27e
	# Download size: 1.1 MB

	# Patch for Log Level Selection (Optional)
	# Optional patch: https://www.linuxfromscratch.org/patches/blfs/12.4/glib-skip_warnings-1.patch
	echoR "Group 4 Security Layer"

	echoL "Downloading Glib (2.84.4) Pass 1..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://download.gnome.org/sources/glib/2.84/glib-2.84.4.tar.xz glib-2.84.4.tar.xz
	cp ../Packages/glib-2.84.4.tar.xz /sources

	../bash/Download.sh https://download.gnome.org/sources/gobject-introspection/1.84/gobject-introspection-1.84.0.tar.xz gobject-introspection-1.84.0.tar.xz
	cp ../Packages/gobject-introspection-1.84.0.tar.xz /sources

	../bash/Download.sh https://www.linuxfromscratch.org/patches/blfs/12.4/glib-skip_warnings-1.patch glib-skip_warnings-1.patch
	cp ../Packages/glib-skip_warnings-1.patch /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Glib (2.84.4) Pass 1..."
	sleep 2
	cd /sources
	rm -fR glib-2.84.4
	tar -vxsf glib-2.84.4.tar.xz
	cd glib-2.84.4

	echoL "Building Glib (2.84.4) Pass 1..."
	sleep 2

	patch -Np1 -i ../glib-skip_warnings-1.patch
	if [ -e /usr/include/glib-2.0 ]; then
		rm -rf /usr/include/glib-2.0.old &&
		mv -vf /usr/include/glib-2.0{,.old}
	fi

	# Install GLib by running the following commands:
	mkdir build &&
	cd    build &&
	meson setup ..                \
		--prefix=/usr             \
		--buildtype=release       \
		-D introspection=disabled \
		-D glib_debug=disabled    \
		-D man-pages=enabled      \
		-D sysprof=disabled       &&
	ninja

	# The GLib test suite requires desktop-file-utils for some tests. However,
	# desktop-file-utils requires GLib in order to compile; therefore, 
	# you must first install GLib and then run the test suite.

	# As the root user, install this package for the first time to allow building GObject Introspection:
	echoL "Installing Glib (2.84.4) Pass 1..."
	sleep 2
	ninja install

	# Build GObject Introspection:
	echoL "Building Glib (2.84.4) Introspection..."
	sleep 2
	tar xf ../../gobject-introspection-1.84.0.tar.xz &&
	meson setup gobject-introspection-1.84.0 gi-build \
		--prefix=/usr --buildtype=release     &&
	ninja -C gi-build

	# To test the results of GObject Introspection, issue: 
	echoL "Testing Glib (2.84.4) Introspection..."
	sleep 2
	ninja -C gi-build test

	# As the root user, install GObject Introspection for generating the introspection data
	# of GLib libraries (required by various packages using Glib, especially some GNOME packages):
	echoL "Installing Glib (2.84.4) Introspection..."
	sleep 2
	ninja -C gi-build install

	# Now generate the introspection data:
	echoL "Generateing Introspection Data..."
	sleep 2
	meson configure -D introspection=enabled &&
	ninja

	echoL "Installing Glib (2.84.4) Pass 1..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR glib-2.84.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
