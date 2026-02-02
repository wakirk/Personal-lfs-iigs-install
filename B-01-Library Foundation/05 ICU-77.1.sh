#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Package Information ICU (77.1)
	# Download (HTTP): https://github.com/unicode-org/icu/releases/download/release-77-1/icu4c-77_1-src.tgz
	# Download MD5 sum: bc0132b4c43db8455d2446c3bae58898
	# Download size: 26 MB
	# Estimated disk space required: 397 MB (add 47 MB for tests)
	# Estimated build time: 0.5 SBU (Using parallelism=4; add 1.8 SBU for tests)
	echoR "Group 1 Library Foundation"

	echoL "Downloading ICU (77.1)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://github.com/unicode-org/icu/releases/download/release-77-1/icu4c-77_1-src.tgz icu4c-77_1-src.tgz
	cp ../Packages/icu4c-77_1-src.tgz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack ICU (77.1)..."
	sleep 2
	cd /sources
	rm -fR icu
	mkdir icu
	mv icu4c-77_1-src.tgz icu
	cd icu
	tar -vxsf icu4c-77_1-src.tgz
	cd icu

	echoL "Building ICU (77.1)..."
	sleep 2
	case $(uname -m) in
		i?86) sed -e "s/U_PLATFORM_IS_LINUX_BASED/__X86_64__ \&\& &/" \
		-i source/test/intltest/ustrtest.cpp ;;
	esac
	cd source
	./configure --prefix=/usr
	make

	echoL "Installing ICU (77.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR icu

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
