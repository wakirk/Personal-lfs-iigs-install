#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://invisible-mirror.net/archives/luit/luit-20240910.tgz
	# Download MD5 sum: c9db8c12a3ad697a075179f07b099eaf
	# Download size: 208 KB
	# Estimated disk space required: 1.8 MB
	# Estimated build time: less than 0.1 SBU	echoR "System Software"
	echoR "System Software"

	echoL "Downloading luit (20240910)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://invisible-mirror.net/archives/luit/luit-20240910.tgz luit-20240910.tgz
	cp ../Packages/luit-20240910.tgz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack luit (20240910)..."
	sleep 2
	cd /sources
	rm -fR luit-20240910
	tar -vxsf luit-20240910.tgz
	cd luit-20240910

	echoL "Building luit (20240910)..."
	sleep 2
	./configure $XORG_CONFIG
	make

	echoL "Installing luit (20240910)..."
	sleep 2
	make install
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR luit-20240910

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
