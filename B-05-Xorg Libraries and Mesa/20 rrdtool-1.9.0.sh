#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# External Project Name RRD Tools 
	# https://github.com/oetiker/rrdtool-1.x/archive/refs/tags/v1.9.0.tar.gz
	# download renamed to rrd_tools-1.9.0.tar.gz
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading RRD tool (1.9.0)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/oetiker/rrdtool-1.x/archive/refs/tags/v1.9.0.tar.gz rrdtool-1.9.0.tar.gz
	cp ../Packages/rrdtool-1.9.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack RRD tool (1.9.0)..."
	sleep 2
	cd /sources
	rm -fR rrdtool-1.9.0
	mkdir rrdtool-1.9.0
	tar -vxsf rrdtool-1.9.0.tar.gz --strip-components=1 -C rrdtool-1.9.0 #fix for the rename.
	cd rrdtool-1.9.0

	echoL "Building RRD tool (1.9.0)..."
	sleep 2
	autoreconf -fvi
	mkdir build
	cd    build
	../configure --prefix=/usr 
	make

	echoL "Installing RRD tool (1.9.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR rrdtool-1.9.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
