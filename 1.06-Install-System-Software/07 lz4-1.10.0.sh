#/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Lz4 (1.10.0) - 379 KB:
	# Home page: https://lz4.org/
	# Download: https://github.com/lz4/lz4/releases/download/v1.10.0/lz4-1.10.0.tar.gz
	# MD5 sum: dead9f5f1966d9ae56e1e32761e4e675
	echoR "System Software"

	echoL "Downloading Lz4 (1.10.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/lz4/lz4/releases/download/v1.10.0/lz4-1.10.0.tar.gz lz4-1.10.0.tar.gz
	cp ../Packages/lz4-1.10.0.tar.gz /sources

	echoL "Unpack Lz4 (1.10.0)..."
	sleep 2
	cd /sources
	rm -fR lz4-1.10.0
	tar -vxsf lz4-1.10.0.tar.gz
	cd lz4-1.10.0

	echoL "Building Lz4 (1.10.0)..."
	sleep 2
	make BUILD_STATIC=no PREFIX=/usr
	make -j1 check

	echoL "Installing Lz4 (1.10.0)..."
	sleep 2
	make BUILD_STATIC=no PREFIX=/usr install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR lz4-1.10.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
