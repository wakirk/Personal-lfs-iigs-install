#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# cURL Dependencies
	# Recommended
	# libpsl-0.21.5

	# Recommended at runtime
	# 	make-ca-1.16.1

	# [Note] Note
	# While there is an option to build the package without libpsl, both the upstream developers
	# and the BLFS editors alike highly recommend not disabling support for libpsl due to severe
	# security implications.

	# Optional
	#	Brotli-1.1.0
	#	c-ares-1.34.5
	#	GnuTLS-3.8.10
	#	libidn2-2.3.8
	#	libssh2-1.11.1
	#	MIT Kerberos V5-1.22.1
	#	nghttp2-1.66.0
	#	OpenLDAP-2.6.10
	#	Samba-4.22.4 (runtime, for NTLM authentication)
	#	gsasl
	#	impacket
	#	libmetalink
	#	librtmp
	#	ngtcp2
	#	quiche
	#	SPNEGO

	# Optional if Running the Test Suite
	#	Apache-2.4.65
	#	stunnel-5.75 (for the HTTPS and FTPS tests)
	#	OpenSSH-10.0p1
	#	Valgrind-3.25.1 (this will slow the tests down and may cause failures)

main () {

	# Download (HTTP): https://curl.se/download/curl-8.15.0.tar.xz
	# Download MD5 sum: b8872bb6cc5d18d03bea8ff5090b2b81
	# Download size: 2.7 MB
	# Estimated disk space required: 49 MB (add 68 MB for tests)
	# Estimated build time: 0.3 SBU (add 4.5 SBU for tests (without valgrind, add 16 SBU with valgrind) all using parallelism=4)
	echoR "Group 3 Support Applications"

	echoL "Downloading cURL (8.15.0)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://curl.se/download/curl-8.15.0.tar.xz curl-8.15.0.tar.xz
	cp ../Packages/curl-8.15.0.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack cURL (8.15.0)..."
	sleep 2
	cd /sources
	rm -fR curl-8.15.0
	tar -vxsf curl-8.15.0.tar.xz
	cd curl-8.15.0

	echoL "Building cURL (8.15.0)..."
	sleep 2
	./configure --prefix=/usr \
		--disable-static      \
		--with-openssl        \
		--with-ca-path=/etc/ssl/certs 
	make

#	echoL "Testing cURL (8.15.0)..."
#	sleep 2
#	make test
#	read

	echoL "Installing cURL (8.15.0)..."
	sleep 2
	make install
	rm -rf docs/examples/.deps
	find docs \( -name Makefile\* -o  \
		-name \*.1       -o  \
		-name \*.3       -o  \
		-name CMakeLists.txt \) -delete
	cp -fv -R docs -T /usr/share/doc/curl-8.15.0
	curl --trace-ascii debugdump.txt https://www.example.com/ 
	curl --trace-ascii d.txt --trace-time https://example.com/

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR curl-8.15.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
