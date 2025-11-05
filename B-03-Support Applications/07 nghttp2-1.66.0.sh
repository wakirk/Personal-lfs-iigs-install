#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# nghttp2 Dependencies
	# Recommended
	# 	libxml2-2.14.5
	# Optional
	# The following are only used if building the full package instead of only the main libraries:
	#	Boost-1.89.0
	#	c-ares-1.34.5
	#	cython-3.1.3
	#	jansson-2.14.1
	#	libevent-2.1.12
	#	sphinx-8.2.3
	#	jemalloc
	#	libev
	#	mruby
	#	Spdylay

main () {

	# Download (HTTP): https://github.com/nghttp2/nghttp2/releases/download/v1.66.0/nghttp2-1.66.0.tar.xz
	# Download MD5 sum: 295c22437cc44e1634a2b82ea93df747
	# Download size: 1.7 MB
	# Estimated disk space required: 20 MB
	# Estimated build time: 0.1 SBU
	echoR "Group 3 Support Applications"

	echoL "Downloading nghttp2 (1.66.0)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://github.com/nghttp2/nghttp2/releases/download/v1.66.0/nghttp2-1.66.0.tar.xz nghttp2-1.66.0.tar.xz
	cp ../Packages/nghttp2-1.66.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack nghttp2 (1.66.0)..."
	sleep 2
	cd /sources
	rm -fR nghttp2-1.66.0
	tar -vxsf nghttp2-1.66.0.tar.xz
	cd nghttp2-1.66.0

	echoL "Building nghttp2 (1.66.0)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--enable-lib-only     \
		--docdir=/usr/share/doc/nghttp2-1.66.0
	make

	echoL "Testing nghttp2 (1.66.0)..."
	sleep 2
	make check

	echoL "Installing nghttp2 (1.66.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR nghttp2-1.66.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
