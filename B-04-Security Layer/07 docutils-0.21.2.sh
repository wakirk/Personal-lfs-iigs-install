#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# 06.5 docutils-0.21.2.sh	https://www.linuxfromscratch.org/blfs/view/stable/general/python-modules.html#docutils

main () {

	# Download (HTTP): https://files.pythonhosted.org/packages/source/d/docutils/docutils-0.21.2.tar.gz
	# Download MD5 sum: c4064e1e0e3cd142951fd2b95b830874
	# Download size: 2.1 MB
	# Estimated disk space required: 10 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 4 Security Layer"

	echoL "Downloading docutils (0.21.2)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://files.pythonhosted.org/packages/source/d/docutils/docutils-0.21.2.tar.gz docutils-0.21.2.tar.gz
	cp ../Packages/docutils-0.21.2.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack docutils (0.21.2)..."
	sleep 2
	cd /sources
	rm -fR docutils-0.21.2
	tar -vxsf docutils-0.21.2.tar.gz
	cd docutils-0.21.2

	echoL "Building docutils (0.21.2)..."
	sleep 2
	for f in /usr/bin/rst*.py; do
		rm -fv /usr/bin/$(basename $f .py)
	done
	pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD

	echoL "Installing docutils (0.21.2)..."
	sleep 2
	pip3 install --no-index --find-links dist --no-user docutils --force-reinstall

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR docutils-0.21.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
