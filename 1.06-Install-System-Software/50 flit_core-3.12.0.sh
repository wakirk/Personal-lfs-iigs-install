#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Flit-core (3.12.0) - 53 KB:
	# Home page: https://pypi.org/project/flit-core/
	# Download: https://pypi.org/packages/source/f/flit-core/flit_core-3.12.0.tar.gz
	# MD5 sum: c538415c1f27bd69cbbbf3cdd5135d39
	echoR "System Software"

	echoL "Downloading Flit-core (3.12.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://pypi.org/packages/source/f/flit-core/flit_core-3.12.0.tar.gz flit_core-3.12.0.tar.gz
	cp ../Packages/flit_core-3.12.0.tar.gz /sources

	echoL "Unpack Flit-core (3.12.0)..."
	sleep 2
	cd /sources
	rm -fR flit_core-3.12.0
	tar -vxsf flit_core-3.12.0.tar.gz
	cd flit_core-3.12.0

	echoL "Building Flit-core (3.12.0)..."
	sleep 2
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

	echoL "Installing Flit-core (3.12.0)..."
	sleep 2
	pip3 install --no-index --find-links dist flit_core

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR flit_core-3.12.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
