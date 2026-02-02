#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# OpenSSL (3.6.0) - 51,934 KB:
	# Home page: https://www.openssl-library.org/
	# Download: https://github.com/openssl/openssl/releases/download/openssl-3.6.0/openssl-3.6.0.tar.gz
	# MD5 sum: 890fc59f86fc21b5e4d1c031a698dbde
	echoR "System Software"

	echoL "Downloading OpenSSL (3.6.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/openssl/openssl/releases/download/openssl-3.6.0/openssl-3.6.0.tar.gz openssl-3.6.0.tar.gz
	cp ../Packages/openssl-3.6.0.tar.gz /sources

	echoL "Unpack OpenSSL (3.6.0)..."
	sleep 2
	cd /sources
	rm -fR openssl-3.6.0
	tar -vxsf openssl-3.6.0.tar.gz
	cd openssl-3.6.0

	echoL "Building OpenSSL (3.6.0)..."
	sleep 2
	./config --prefix=/usr    \
		--openssldir=/etc/ssl \
		--libdir=lib          \
		shared                \
		zlib-dynamic
	make

	echoL "Testing OpenSSL (3.6.0)..."
	sleep 2
	HARNESS_JOBS=$(nproc) make test
	echo "One test, 30-test_afalg.t, is known to fail if the host kernel does not have CONFIG_CRYPTO_USER_API_SKCIPHER enabled, or does not have any options providing an AES with CBC implementation (for example, the combination of CONFIG_CRYPTO_AES and CONFIG_CRYPTO_CBC, or CONFIG_CRYPTO_AES_NI_INTEL if the CPU supports AES-NI) enabled. If it fails, it can safely be ignored."

	echoL "Installing OpenSSL (3.6.0)..."
	sleep 2
	sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
	make MANSUFFIX=ssl install
	mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.6.0
	cp -vfr doc/* /usr/share/doc/openssl-3.6.0

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR openssl-3.6.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
