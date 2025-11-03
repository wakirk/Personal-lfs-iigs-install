#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# p11-kit Dependencies
	# Recommended
	# 	libtasn1-4.20.0

	# Recommended (runtime)
	#	make-ca-1.16.1

	# Optional
	# 	GTK-Doc-1.34.0
	# 	libxslt-1.1.43
	# 	nss-3.115 (runtime)

main () {

	# Download (HTTP): https://github.com/p11-glue/p11-kit/releases/download/0.25.5/p11-kit-0.25.5.tar.xz
	# Download MD5 sum: e9c5675508fcd8be54aa4c8cb8e794fc
	# Download size: 980 KB
	# Estimated disk space required: 94 MB (with tests)
	# Estimated build time: 0.7 SBU (with tests)
	echoR "Group 2 Support Library"

	echoL "Downloading p11-kit (0.25.5)..."
	sleep 2
	cd "/root/lfs/B-02-Support Library"
	../bash/Download.sh https://github.com/p11-glue/p11-kit/releases/download/0.25.5/p11-kit-0.25.5.tar.xz p11-kit-0.25.5.tar.xz
	cp ../Packages/p11-kit-0.25.5.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack p11-kit (0.25.5)..."
	sleep 2
	cd /sources
	rm -fR p11-kit-0.25.5
	tar -vxsf p11-kit-0.25.5.tar.xz
	cd p11-kit-0.25.5

	echoL "Building p11-kit (0.25.5)..."
	sleep 2
	sed '20,$ d' -i trust/trust-extract-compat &&
	cat >> trust/trust-extract-compat << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Update trust stores
/usr/sbin/make-ca -r
EOF
	mkdir p11-build
	cd    p11-build
	meson setup ..      \
	--prefix=/usr       \
	--buildtype=release \
	-D trust_paths=/etc/pki/anchors
	ninja

	echoL "Testing p11-kit (0.25.5)..."
	sleep 2
	LC_ALL=C ninja test

	echoL "Installing p11-kit (0.25.5)..."
	sleep 2
	ninja install
	ln -sfv /usr/libexec/p11-kit/trust-extract-compat /usr/bin/update-ca-certificates
	ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR p11-kit-0.25.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
