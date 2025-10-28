#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Mako (1.3.10)
	# Download (HTTP): https://files.pythonhosted.org/packages/source/M/Mako/mako-1.3.10.tar.gz
	# Download MD5 sum: c9dfb2bf42827459dd505c60f2262a7c
	# Download size: 384 KB
	# Estimated disk space required: 3.9 MB (with tests)
	# Estimated build time: less than 0.1 SBU (with tests)
	echoR "System Software"

	echoL "Downloading Mako (1.3.10)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://files.pythonhosted.org/packages/source/M/Mako/mako-1.3.10.tar.gz mako-1.3.10.tar.gz
	cp ../Packages/mako-1.3.10.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Mako (1.3.10)..."
	sleep 2
	cd /sources
	rm -fR mako-1.3.10
	tar -vxsf mako-1.3.10.tar.gz
	cd mako-1.3.10

	echoL "Building Mako (1.3.10)..."
	sleep 2
	pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD

	echoL "Installing Mako (1.3.10)..."
	sleep 2
	pip3 install --no-index --find-links dist --no-user Mako

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR mako-1.3.10

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
