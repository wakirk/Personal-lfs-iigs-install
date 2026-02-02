#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# rust-bindgen Dependencies
# Required
#	rustc-1.89.0
#	LLVM-20.1.8 (with Clang, runtime)

main () {

	# Download (HTTP): https://github.com/rust-lang/rust-bindgen/archive/v0.72.0/rust-bindgen-0.72.0.tar.gz
	# Download MD5 sum: 15888c0e5c60a1d367cf6c1b6e51c067
	# Download size: 2.2 MB
	# Estimated disk space required: 219 MB
	# Estimated build time: 0.3 SBU (with parallelism=8)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading rust-bindgen (0.72.0)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/rust-lang/rust-bindgen/archive/v0.72.0/rust-bindgen-0.72.0.tar.gz rust-bindgen-0.72.0.tar.gz
	cp ../Packages/rust-bindgen-0.72.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack rust-bindgen (0.72.0)..."
	sleep 2
	cd /sources
	rm -fR rust-bindgen-0.72.0
	tar -vxsf rust-bindgen-0.72.0.tar.gz
	cd rust-bindgen-0.72.0

	echoL "Building rust-bindgen (0.72.0)..."
	sleep 2
	cargo build --release

	echoL "Testing rust-bindgen (0.72.0)..."
	sleep 2
	cargo test --release

	echoL "Installing rust-bindgen (0.72.0)..."
	sleep 2
	install -v -m755 target/release/bindgen /usr/bin
	bindgen --generate-shell-completions bash > /usr/share/bash-completion/completions/bindgen
	bindgen --generate-shell-completions zsh  > /usr/share/zsh/site-functions/_bindgen

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR rust-bindgen-0.72.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
