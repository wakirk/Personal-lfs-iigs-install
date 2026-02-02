#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Setuptools (80.9.0) - 1,290 KB:
	# Home page: https://pypi.org/project/setuptools/
	# Download: https://pypi.org/packages/source/s/setuptools/setuptools-80.9.0.tar.gz
	# MD5 sum: 82e1d67883b713f9493659b50d13b436
	echoR "System Software"

	echoL "Downloading Setuptools (80.9.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://pypi.org/packages/source/s/setuptools/setuptools-80.9.0.tar.gz setuptools-80.9.0.tar.gz
	cp ../Packages/setuptools-80.9.0.tar.gz /sources

	echoL "Unpack Setuptools (80.9.0)..."
	sleep 2
	cd /sources
	rm -fR setuptools-80.9.0
	tar -vxsf setuptools-80.9.0.tar.gz
	cd setuptools-80.9.0

	echoL "Building Setuptools (80.9.0)..."
	sleep 2
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

	echoL "Installing Setuptools (80.9.0)..."
	sleep 2
	pip3 install --no-index --find-links dist setuptools

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR setuptools-80.9.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
