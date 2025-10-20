#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# MarkupSafe (3.0.2) - 21 KB:
	# Home page: https://palletsprojects.com/p/markupsafe/
	# Download: https://pypi.org/packages/source/M/MarkupSafe/markupsafe-3.0.2.tar.gz
	# MD5 sum: cb0071711b573b155cc8f86e1de72167
	echoR "System Software"

	echoL "Downloading MarkupSafe (3.0.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://pypi.org/packages/source/M/MarkupSafe/markupsafe-3.0.2.tar.gz markupsafe-3.0.2.tar.gz
	cp ../Packages/markupsafe-3.0.2.tar.gz /sources

	echoL "Unpack MarkupSafe (3.0.2)..."
	sleep 2
	cd /sources
	rm -fR markupsafe-3.0.2
	tar -vxsf markupsafe-3.0.2.tar.gz
	cd markupsafe-3.0.2

	echoL "Building MarkupSafe (3.0.2)..."
	sleep 2
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

	echoL "Installing MarkupSafe (3.0.2)..."
	sleep 2
	pip3 install --no-index --find-links dist Markupsafe

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR markupsafe-3.0.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
