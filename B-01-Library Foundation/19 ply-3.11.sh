#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://files.pythonhosted.org/packages/source/p/ply/ply-3.11.tar.gz
	# Download MD5 sum: 6465f602e656455affcd7c5734c638f8
	# Download size: 156 KB
	# Estimated disk space required: 2.2 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 1 Library Foundation"

	echoL "Downloading ply (3.11)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://files.pythonhosted.org/packages/source/p/ply/ply-3.11.tar.gz ply-3.11.tar.gz
	cp ../Packages/ply-3.11.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack ply (3.11)..."
	sleep 2
	cd /sources
	rm -fR ply-3.11
	tar -vxsf ply-3.11.tar.gz
	cd ply-3.11

	echoL "Building ply (3.11)..."
	sleep 2
	pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD

	echoL "Installing ply (3.11)..."
	sleep 2
	pip3 install --no-index --find-links dist --no-user ply

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR ply-3.11

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
