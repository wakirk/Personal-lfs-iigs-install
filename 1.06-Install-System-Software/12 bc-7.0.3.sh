#/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Bc (7.0.3) - 464 KB:
	# Home page: https://github.com/gavinhoward
	# Download: https://github.com/gavinhoward/bc/releases/download/7.0.3/bc-7.0.3.tar.xz
	# MD5 sum: ad4db5a0eb4fdbb3f6813be4b6b3da74
	echoR "System Software"

	echoL "Downloading Bc (7.0.3)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/gavinhoward/bc/releases/download/7.0.3/bc-7.0.3.tar.xz bc-7.0.3.tar.xz
	cp ../Packages/bc-7.0.3.tar.xz /sources

	echoL "Unpack Bc (7.0.3)..."
	sleep 2
	cd /sources
	rm -fR bc-7.0.3
	tar -vxsf bc-7.0.3.tar.xz
	cd bc-7.0.3

	echoL "Building Bc (7.0.3)..."
	sleep 2
	CC='gcc -std=c99' ./configure --prefix=/usr -G -O3 -r
	make

	echoL "Testing Bc (7.0.3)..."
	make test

	echoL "Installing Bc (7.0.3)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR bc-7.0.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
