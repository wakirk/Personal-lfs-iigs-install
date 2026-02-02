#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	libevdev-1.13.4
	#	mtdev-1.1.7

	# Optional
	#	Valgrind-3.25.1 (to run the tests), 
	# 	GTK-3.24.50 (to build the GUI event viewer)
	# 	libunwind-1.8.2 (required for tests)
	#	libwacom-2.16.1
	#	Doxygen-1.14.0
	#	Graphviz-13.1.2
	#	recommonmark-0.7.1
	#	sphinx_rtd_theme-3.0.2 (required to build documentation)
	#	pyparsing-3.2.3 (for one non-root test)
	#	pytest-8.4.1 (for another non-root test)
	#	check (for another non-root test)

main () {

	# Package Information: https://www.linuxfromscratch.org/blfs/view/stable/x/x7driver.html#libinput
	# Download (HTTP): https://gitlab.freedesktop.org/libinput/libinput/-/archive/1.29.0/libinput-1.29.0.tar.gz
	# Download MD5 sum: 7c243cf456aff35b57412527ee8143e4
	# Download size: 1.1 MB
	# Estimated disk space required: 13 MB (add 35 MB for documentation and 9 MB for minor tests)
	# Estimated build time: 0.1 SBU (add 0.1 SBU for documentation and 0.3 SBU for minor tests)
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading libinput (1.29.0)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://gitlab.freedesktop.org/libinput/libinput/-/archive/1.29.0/libinput-1.29.0.tar.gz libinput-1.29.0.tar.gz
	cp ../Packages/libinput-1.29.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libinput (1.29.0)..."
	sleep 2
	cd /sources
	rm -fR libinput-1.29.0
	tar -vxsf libinput-1.29.0.tar.gz
	cd libinput-1.29.0

	echoL "Building libinput (1.29.0)..."
	sleep 2
	mkdir build
	cd    build
	meson setup ..            \
		--prefix=$XORG_PREFIX \
		--buildtype=release   \
		-D debug-gui=false    \
		-D tests=false        \
		-D libwacom=false     \
		-D udev-dir=/usr/lib/udev &&
	ninja

	echoL "Testing libinput (1.29.0)..."
	sleep 2
	meson configure -D tests=true --suite=root 
	ninja test

	echoL "Installing libinput (1.29.0)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libinput-1.29.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
