#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	# 	Nettle-3.10.2

	# Recommended
	# 	make-ca-1.16.1
	#	libunistring-1.3
	#	libtasn1-4.20.0
	#	p11-kit-0.25.5

	# Optional
	# 	Brotli-1.1.0
	#	Doxygen-1.14.0
	#	GTK-Doc-1.34.0
	#	libidn-1.43 
	#	libidn2-2.3.8
	#	libseccomp-2.6.0
	#	Net-tools-2.10 (used during the test suite)
	#	texlive-20250308 or install-tl-unx, 
	#	Unbound-1.23.1 (to build the DANE library)
	#	Valgrind-3.25.1 (used during the test suite)
	#	autogen
	#	cmocka and datefudge (used during the test suite if the DANE library is built)
	#	leancrypto, and Trousers (Trusted Platform Module support)

main () {

	# Download (HTTP): https://www.gnupg.org/ftp/gcrypt/gnutls/v3.8/gnutls-3.8.10.tar.xz
	# Download MD5 sum: 803c6f5c9cbe55c64fbb46690d329a77
	# Download size: 6.5 MB
	# Estimated disk space required: 178 MB (add 111 MB for tests)
	# Estimated build time: 0.6 SBU (add 1.4 SBU for tests; both using parallelism=8)
	echoR "Group 3 Support Applications"

	echoL "Downloading GnuTLS (3.8.10)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://www.gnupg.org/ftp/gcrypt/gnutls/v3.8/gnutls-3.8.10.tar.xz gnutls-3.8.10.tar.xz
	cp ../Packages/gnutls-3.8.10.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack GnuTLS (3.8.10)..."
	sleep 2
	cd /sources
	rm -fR gnutls-3.8.10
	tar -vxsf gnutls-3.8.10.tar.xz
	cd gnutls-3.8.10

	echoL "Building GnuTLS (3.8.10)..."
	sleep 2
	./configure --prefix=/usr             \
	--docdir=/usr/share/doc/gnutls-3.8.10 \
	--with-default-trust-store-pkcs11="pkcs11:"
	make

	echoL "Testing GnuTLS (3.8.10)..."
	sleep 2
	make check

	echoL "Installing GnuTLS (3.8.10)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gnutls-3.8.10

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
