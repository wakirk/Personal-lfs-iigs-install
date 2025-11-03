#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://github.com/cython/cython/releases/download/3.1.3/cython-3.1.3.tar.gz
	# Download MD5 sum: f508595cc0951a77b70c07100df1b4ff
	# Download size: 3.1 MB
	# Estimated disk space required: 137 MB
	# Estimated build time: 1.0 SBU
	echoR "Group 1 Library Foundation"

	echoL "Downloading Cython (3.1.3)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://github.com/cython/cython/releases/download/3.1.3/cython-3.1.3.tar.gz cython-3.1.3.tar.gz
	cp ../Packages/cython-3.1.3.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Cython (3.1.3)..."
	sleep 2
	cd /sources
	rm -fR cython-3.1.3
	tar -vxsf cython-3.1.3.tar.gz
	cd cython-3.1.3

	echoL "Building Cython (3.1.3)..."
	sleep 2
	pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD

	echoL "Installing Cython (3.1.3)..."
	sleep 2
	pip3 install --no-index --find-links dist --no-user Cython

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR cython-3.1.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
