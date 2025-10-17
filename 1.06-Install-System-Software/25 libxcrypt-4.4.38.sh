#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

Libxcrypt (4.4.38) - 612 KB:
Home page: https://github.com/besser82/libxcrypt/
Download: https://github.com/besser82/libxcrypt/releases/download/v4.4.38/libxcrypt-4.4.38.tar.xz
MD5 sum: 1796a5d20098e9dd9e3f576803c83000
	echoR "System Software"

	echoL "Downloading Libxcrypt (4.4.38)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/besser82/libxcrypt/releases/download/v4.4.38/libxcrypt-4.4.38.tar.xz libxcrypt-4.4.38.tar.xz
	cp ../Packages/libxcrypt-4.4.38.tar.xz /sources

	echoL "Unpack Libxcrypt (4.4.38)..."
	sleep 2
	cd /sources
	rm -fR libxcrypt-4.4.38
	tar -vxsf libxcrypt-4.4.38.tar.xz
	cd libxcrypt-4.4.38

	echoL "Building Libxcrypt (4.4.38)..."
	sleep 2
./configure --prefix=/usr                \
            --enable-hashes=strong,glibc \
            --enable-obsolete-api=no     \
            --disable-static             \
            --disable-failure-tokens
  make
  
	echoL "Testing Libxcrypt (4.4.38)..."
  sleep 2
  make check
	
	echoL "Installing Libxcrypt (4.4.38)..."
	sleep 2
  make install
	
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libxcrypt-4.4.38

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1










