#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Packaging (25.0) - 162 KB:
	# Home page: https://pypi.org/project/packaging/
	# Download: https://files.pythonhosted.org/packages/source/p/packaging/packaging-25.0.tar.gz
	# MD5 sum: ab0ef21ddebe09d1803575120d3f99f8
	echoR "System Software"

	echoL "Downloading Packaging (25.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://files.pythonhosted.org/packages/source/p/packaging/packaging-25.0.tar.gz packaging-25.0.tar.gz
	cp ../Packages/packaging-25.0.tar.gz /sources

	echoL "Unpack Packaging (25.0)..."
	sleep 2
	cd /sources
	rm -fR packaging-25.0
	tar -vxsf packaging-25.0.tar.gz
	cd packaging-25.0

	echoL "Building Packaging (25.0)..."
	sleep 2
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

	echoL "Installing Packaging (25.0)..."
	sleep 2
	pip3 install --no-index --find-links dist packaging

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR packaging-25.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
