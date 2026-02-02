#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	CrackLib-2.10.3

	# Recommended
	#	Linux-PAM-1.7.1

main () {

	# Download (HTTP): https://github.com/libpwquality/libpwquality/releases/download/libpwquality-1.4.5/libpwquality-1.4.5.tar.bz2
	# Download MD5 sum: 6b70e355269aef0b9ddb2b9d17936f21
	# Download size: 424 KB
	# Estimated disk space required: 5.4 MB
	# Estimated build time: 0.1 SBU
	echoR "Group 4 Security Layer"

	echoL "Downloading libpwquality (1.4.5)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://github.com/libpwquality/libpwquality/releases/download/libpwquality-1.4.5/libpwquality-1.4.5.tar.bz2 libpwquality-1.4.5.tar.bz2
	cp ../Packages/libpwquality-1.4.5.tar.bz2 /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libpwquality (1.4.5)..."
	sleep 2
	cd /sources
	rm -fR libpwquality-1.4.5
	tar -vxsf libpwquality-1.4.5.tar.bz2
	cd libpwquality-1.4.5

	echoL "Building libpwquality (1.4.5)..."
	sleep 2
	./configure --prefix=/usr          \
	--disable-static                   \
	--with-securedir=/usr/lib/security \
	--disable-python-bindings
	make
	pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD/python

	echoL "Installing libpwquality (1.4.5)..."
	sleep 2
	make install
	pip3 install --no-index --find-links dist --no-user pwquality

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libpwquality-1.4.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
