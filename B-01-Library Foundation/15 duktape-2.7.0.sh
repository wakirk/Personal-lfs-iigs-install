#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://duktape.org/duktape-2.7.0.tar.xz
	# Download MD5 sum: b3200b02ab80125b694bae887d7c1ca6
	# Download size: 1003 KB
	# Estimated disk space required: 25 MB
	# Estimated build time: 0.3 SBU
	echoR "Group 1 Library Foundation"

	echoL "Downloading Duktape (2.7.0)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://duktape.org/duktape-2.7.0.tar.xz duktape-2.7.0.tar.xz
	cp ../Packages/duktape-2.7.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Duktape (2.7.0)..."
	sleep 2
	cd /sources
	rm -fR duktape-2.7.0
	tar -vxsf duktape-2.7.0.tar.xz
	cd duktape-2.7.0

	echoL "Building Duktape (2.7.0)..."
	sleep 2
	sed -i 's/-Os/-O2/' Makefile.sharedlibrary
	make -f Makefile.sharedlibrary INSTALL_PREFIX=/usr

	echoL "Installing Duktape (2.7.0)..."
	sleep 2
	make -f Makefile.sharedlibrary INSTALL_PREFIX=/usr install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR duktape-2.7.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
