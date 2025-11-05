#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Recommended
	#	GLib-2.84.4 (required for Pango; GObject Introspection required for building GNOME),
	#	Graphite2-1.3.14 (required for building texlive-20250308 or
	#	LibreOffice-25.8.1.1 with system harfbuzz)
	#	ICU-77.1
	#	FreeType-2.13.3 (after harfbuzz is installed, reinstall freetype)

	# Optional
	# Cairo-1.18.4 (circular: build cairo and all its recommended dependencies, 
	#		including harfbuzz, first, then rebuild harfbuzz if the cairo backend is needed),
	#	git-2.50.1
	#	GTK-Doc-1.34.0
	#	FontTools (Python 3 module, for the test suite)
	#	ragel
	#	wasm-micro-runtime

	# [Warning] Warning
	# Recommended dependencies are not strictly required to build the package.
	# However, you might not get expected results at runtime if you don't install them.
	# Please do not report bugs with this package if you have not installed
	# the recommended dependencies.

main () {

	# Download (HTTP): https://github.com/harfbuzz/harfbuzz/releases/download/11.4.1/harfbuzz-11.4.1.tar.xz
	# Download MD5 sum: 0f2f8fe443032019b5ca9598c8e2b912
	# Download size: 17 MB
	# Estimated disk space required: 143 MB (with tests)
	# Estimated build time: 0.7 SBU (with tests; both using parallelism=4)
	echoR "Group 4 Security Layer"

	echoL "Downloading harfBuzz (11.4.1)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://github.com/harfbuzz/harfbuzz/releases/download/11.4.1/harfbuzz-11.4.1.tar.xz harfbuzz-11.4.1.tar.xz
	cp ../Packages/harfbuzz-11.4.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack harfBuzz (11.4.1)..."
	sleep 2
	cd /sources
	rm -fR harfbuzz-11.4.1
	tar -vxsf harfbuzz-11.4.1.tar.xz
	cd harfbuzz-11.4.1

	echoL "Building harfBuzz (11.4.1)..."
	sleep 2
	mkdir build &&
	cd    build &&
	meson setup ..           \
		--prefix=/usr        \
		--buildtype=release &&
	ninja

	echoL "Testing harfBuzz (11.4.1)..."
	sleep 2
	ninja test

	echoL "Installing harfBuzz (11.4.1)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR harfbuzz-11.4.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
