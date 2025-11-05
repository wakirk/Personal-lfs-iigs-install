#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# PCRE2 Dependencies
	#	Optional
	#	Valgrind-3.25.1
	#	libedit

main () {

	# Download (HTTP): https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.45/pcre2-10.45.tar.bz2
	# Download MD5 sum: f71abbe1b5adf25cd9af5d26ef223b66
	# Download size: 2.0 MB
	# Estimated disk space required: 20 MB (with tests)
	# Estimated build time: 0.5 SBU (with tests)
	echoR "Group 3 Support Applications"

	echoL "Downloading PCRE2 (10.45)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.45/pcre2-10.45.tar.bz2 pcre2-10.45.tar.bz2
	cp ../Packages/pcre2-10.45.tar.bz2 /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack PCRE2 (10.45)..."
	sleep 2
	cd /sources
	rm -fR pcre2-10.45
	tar -vxsf pcre2-10.45.tar.bz2
	cd pcre2-10.45

	echoL "Building PCRE2 (10.45)..."
	sleep 2
	./configure --prefix=/usr           \
	--docdir=/usr/share/doc/pcre2-10.45 \
	--enable-unicode                    \
	--enable-jit                        \
	--enable-pcre2-16                   \
	--enable-pcre2-32                   \
	--enable-pcre2grep-libz             \
	--enable-pcre2grep-libbz2           \
	--enable-pcre2test-libreadline      \
	--disable-static                    &&
	make

	echoL "Testing PCRE2 (10.45)..."
	sleep 2
	make check

	echoL "Installing PCRE2 (10.45)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR pcre2-10.45

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
