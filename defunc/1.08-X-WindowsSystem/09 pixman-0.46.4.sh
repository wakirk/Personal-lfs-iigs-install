#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://www.cairographics.org/releases/pixman-0.46.4.tar.gz
	# Download MD5 sum: c08173c8e1d2cc79428d931c13ffda59
	# Download size: 808 KB
	# Estimated disk space required: 28 MB (With tests)
	# Estimated build time: 0.1 SBU (Using parallelism=4; with tests)
	echoR "System Software"

	echoL "Downloading pixman (0.46.4)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.cairographics.org/releases/pixman-0.46.4.tar.gz pixman-0.46.4.tar.gz
	cp ../Packages/pixman-0.46.4.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack pixman (0.46.4)..."
	sleep 2
	cd /sources
	rm -fR pixman-0.46.4
	tar -vxsf pixman-0.46.4.tar.gz
	cd pixman-0.46.4

	echoL "Building pixman (0.46.4)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=/usr --buildtype=release ..
	ninja

	echoL "Installing pixman (0.46.4)..."
	sleep 2
	ninja install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR pixman-0.46.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
