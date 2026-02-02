#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# Recommended
# libpsl-0.21.5

# Recommended at runtime
# make-ca-1.16.1

# Optional
# GnuTLS-3.8.10
# HTTP-Daemon-6.16 (for the test suite)
# IO-Socket-SSL-2.095 (for the test suite)
# libidn2-2.3.8
# libproxy-0.5.10
# pcre2-10.45
# Valgrind-3.25.1 (for the test suite)

main () {

	# Download (HTTP): https://ftp.gnu.org/gnu/wget/wget-1.25.0.tar.gz
	# Download MD5 sum: c70ba58b36f944e8ba1d655ace552881
	# Download size: 5.0 MB
	# Estimated disk space required: 38 MB (add 27 MB for tests)
	# Estimated build time: 0.3 SBU (add 0.4 SBU for tests)
	echoR "Group 4 Security Layer"

	echoL "Downloading Wget (1.25.0)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://ftp.gnu.org/gnu/wget/wget-1.25.0.tar.gz wget-1.25.0.tar.gz
	cp ../Packages/wget-1.25.0.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Wget (1.25.0)..."
	sleep 2
	cd /sources
	rm -fR wget-1.25.0
	tar -vxsf wget-1.25.0.tar.gz
	cd wget-1.25.0

	echoL "Building Wget (1.25.0)..."
	sleep 2
	./configure --prefix=/usr   \
		--enable-valgrind-tests \
		--sysconfdir=/etc       \
		--with-ssl=openssl
	make

	echoL "Testing Wget (1.25.0)..."
	sleep 2
#	make check
#	read
	
	echoL "Installing Wget (1.25.0)..."
	sleep 2
	make install
#	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR wget-1.25.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
