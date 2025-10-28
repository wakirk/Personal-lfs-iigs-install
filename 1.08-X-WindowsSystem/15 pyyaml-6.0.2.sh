#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://files.pythonhosted.org/packages/source/P/PyYAML/pyyaml-6.0.2.tar.gz
	# Download MD5 sum: 9600ee49b2b4e1a0237cf4173b6dc594
	# Download size: 128 KB
	# Estimated disk space required: 8.5 MB
	# Estimated build time: 0.1 SBU	
	echoR "System Software"

	echoL "Downloading PyYAML (6.0.2)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://files.pythonhosted.org/packages/source/P/PyYAML/pyyaml-6.0.2.tar.gz pyyaml-6.0.2.tar.gz
	cp ../Packages/pyyaml-6.0.2.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack PyYAML (6.0.2)..."
	sleep 2
	cd /sources
	rm -fR pyyaml-6.0.2
	tar -vxsf pyyaml-6.0.2.tar.gz
	cd pyyaml-6.0.2

	echoL "Building PyYAML (6.0.2)..."
	sleep 2
	pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD

	echoL "Installing PyYAML (6.0.2)..."
	sleep 2
	pip3 install --no-index --find-links dist --no-user PyYAML

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR pyyaml-6.0.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
