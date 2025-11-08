#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	rustc-1.89.0

main () {

	# Download (HTTP): https://github.com/mozilla/cbindgen/archive/v0.29.0/cbindgen-0.29.0.tar.gz
	# Download MD5 sum: 6020b670f82890ef7205fd2c84395954
	# Download size: 236 KB
	# Estimated disk space required: 123 MB (add 576 MB for tests)
	# Estimated build time: 0.4 SBU (add 0.2 SBU for tests), both on a 4-core machine
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Cbindgen (0.29.0)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/mozilla/cbindgen/archive/v0.29.0/cbindgen-0.29.0.tar.gz cbindgen-0.29.0.tar.gz
	cp ../Packages/cbindgen-0.29.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Cbindgen (0.29.0)..."
	sleep 2
	cd /sources
	rm -fR cbindgen-0.29.0
	tar -vxsf cbindgen-0.29.0.tar.gz
	cd cbindgen-0.29.0

	echoL "Building Cbindgen (0.29.0)..."
	sleep 2
	cargo build --release

	echoL "Testing Cbindgen (0.29.0)..."
	sleep 2
	cargo test --release

	echoL "Installing Cbindgen (0.29.0)..."
	sleep 2
	install -Dm755 target/release/cbindgen /usr/bin/

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR cbindgen-0.29.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
