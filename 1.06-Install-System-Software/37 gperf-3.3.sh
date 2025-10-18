#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Gperf (3.3) - 1,789 KB:
	# Home page: https://www.gnu.org/software/gperf/
	# Download: https://ftp.gnu.org/gnu/gperf/gperf-3.3.tar.gz
	# MD5 sum: 31753b021ea78a21f154bf9eecb8b079
	echoR "System Software"

	echoL "Downloading Gperf (3.3)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/gperf/gperf-3.3.tar.gz gperf-3.3.tar.gz
	cp ../Packages/gperf-3.3.tar.gz /sources

	echoL "Unpack Gperf (3.3)..."
	sleep 2
	cd /sources
	rm -fR gperf-3.3
	tar -vxsf gperf-3.3.tar.gz
	cd gperf-3.3

	echoL "Building Gperf (3.3)..."
	sleep 2
	./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.3
	make

	echoL "Testing Gperf (3.3)..."
	sleep 2
	make check

	echoL "Installing Gperf (3.3)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gperf-3.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
