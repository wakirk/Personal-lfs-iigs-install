#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# libyaml Dependencies
# Optional
# 	Doxygen-1.14.0

main () {

	# Download (HTTP): https://github.com/yaml/libyaml/releases/download/0.2.5/yaml-0.2.5.tar.gz
	# Download MD5 sum: bb15429d8fb787e7d3f1c83ae129a999
	# Download size: 596 KB
	# Estimated disk space required: 6.4 MB (with tests)
	# Estimated build time: less than 0.1 SBU (with tests)
	echoR "Group 1 Library Foundation"

	echoL "Downloading Libyaml (0.2.5)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://github.com/yaml/libyaml/releases/download/0.2.5/yaml-0.2.5.tar.gz yaml-0.2.5.tar.gz
	cp ../Packages/yaml-0.2.5.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Libyaml (0.2.5)..."
	sleep 2
	cd /sources
	rm -fR yaml-0.2.5
	tar -vxsf yaml-0.2.5.tar.gz
	cd yaml-0.2.5

	echoL "Building Libyaml (0.2.5)..."
	sleep 2
	./configure --prefix=/usr --disable-static
	make

	echoL "Testing Libyaml (0.2.5)..."
	sleep 2
	make check

	echoL "Installing Libyaml (0.2.5)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR yaml-0.2.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
