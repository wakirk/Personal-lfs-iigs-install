#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Wheel (0.46.1) - 54 KB:
	# Home page: https://pypi.org/project/wheel/
	# Download: https://pypi.org/packages/source/w/wheel/wheel-0.46.1.tar.gz
	# MD5 sum: 65e09ee84af36821e3b1e9564aa91bd5
	echoR "System Software"

	echoL "Downloading Wheel (0.46.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://pypi.org/packages/source/w/wheel/wheel-0.46.1.tar.gz wheel-0.46.1.tar.gz
	cp ../Packages/wheel-0.46.1.tar.gz /sources

	echoL "Unpack Wheel (0.46.1)..."
	sleep 2
	cd /sources
	rm -fR wheel-0.46.1
	tar -vxsf wheel-0.46.1.tar.gz
	cd wheel-0.46.1

	echoL "Building Wheel (0.46.1)..."
	sleep 2
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

	echoL "Installing Wheel (0.46.1)..."
	sleep 2
	pip3 install --no-index --find-links dist wheel

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR wheel-0.46.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
